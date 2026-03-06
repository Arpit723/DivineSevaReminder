import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../domain/entities/user/user.dart';
import '../../../../domain/repositories/auth_repository.dart';
import '../../../../core/errors/failures.dart';

/// Implementation of AuthRepository using Firebase Authentication
class FirebaseAuthService implements AuthRepository {
  final firebase_auth.FirebaseAuth? _firebaseAuth;
  final GoogleSignIn? _googleSignIn;
  final FirebaseFirestore? _firestore;
  final bool _isFirebaseInitialized;

  FirebaseAuthService({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    FirebaseFirestore? firestore,
  })  : _isFirebaseInitialized = Firebase.apps.isNotEmpty,
        _firebaseAuth = Firebase.apps.isNotEmpty
            ? (firebaseAuth ?? firebase_auth.FirebaseAuth.instance)
            : null,
        _googleSignIn = Firebase.apps.isNotEmpty
            ? (googleSignIn ?? GoogleSignIn.standard())
            : null,
        _firestore = Firebase.apps.isNotEmpty
            ? (firestore ?? FirebaseFirestore.instance)
            : null;

  /// Check if Firebase is initialized
  bool get isFirebaseAvailable => _isFirebaseInitialized && _firebaseAuth != null;

  @override
  Stream<Either<Failure, User?>> get authStateChanges {
    if (!isFirebaseAvailable) {
      // Return a stream that emits null user when Firebase is not available
      return Stream.value(const Right(null));
    }
    return _firebaseAuth!.authStateChanges().map(
      (firebaseUser) {
        if (firebaseUser == null) {
          return const Right(null);
        }
        try {
          return Right(_convertFirebaseUser(firebaseUser));
        } catch (e, st) {
          return Left(Failure.unknown(e, st));
        }
      },
    );
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    if (!isFirebaseAvailable) {
      return const Right(null);
    }
    try {
      final firebaseUser = _firebaseAuth!.currentUser;
      if (firebaseUser == null) {
        return const Right(null);
      }

      // Fetch additional user data from Firestore
      final userDoc = await _firestore!.collection('users').doc(firebaseUser.uid).get();
      if (userDoc.exists) {
        return Right(User.fromJson(userDoc.data()!));
      }

      return Right(_convertFirebaseUser(firebaseUser));
    } catch (e, st) {
      return Left(Failure.unknown(e, st));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    if (!isFirebaseAvailable) {
      return Left(Failure.auth('Firebase is not initialized. Please configure Firebase.'));
    }
    try {
      final credential = await _firebaseAuth!.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = _convertFirebaseUser(credential.user!);
      await _saveUserToFirestore(user);

      return Right(user);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(Failure.auth(_getAuthErrorMessage(e.code)));
    } catch (e, st) {
      return Left(Failure.unknown(e, st));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
  }) async {
    if (!isFirebaseAvailable) {
      return Left(Failure.auth('Firebase is not initialized. Please configure Firebase.'));
    }
    try {
      final credential = await _firebaseAuth!.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name
      await credential.user?.updateDisplayName(fullName);

      final user = User.create(
        id: credential.user!.uid,
        email: email,
        fullName: fullName,
        phoneNumber: phoneNumber,
      );

      await _saveUserToFirestore(user);

      return Right(user);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(Failure.auth(_getAuthErrorMessage(e.code)));
    } catch (e, st) {
      return Left(Failure.unknown(e, st));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithGoogle() async {
    if (!isFirebaseAvailable) {
      return Left(Failure.auth('Firebase is not initialized. Please configure Firebase.'));
    }
    try {
      final googleUser = await _googleSignIn!.signIn();
      if (googleUser == null) {
        return Left(Failure.auth('Google sign-in was cancelled'));
      }

      final googleAuth = await googleUser.authentication;

      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth!.signInWithCredential(credential);
      final firebaseUser = userCredential.user!;

      // Check if user exists in Firestore
      final userDoc = await _firestore!.collection('users').doc(firebaseUser.uid).get();
      User user;

      if (userDoc.exists) {
        user = User.fromJson(userDoc.data()!);
      } else {
        user = User.create(
          id: firebaseUser.uid,
          email: firebaseUser.email!,
          fullName: firebaseUser.displayName ?? 'Google User',
          phoneNumber: firebaseUser.phoneNumber,
          photoUrl: firebaseUser.photoURL,
        );
        await _saveUserToFirestore(user);
      }

      return Right(user);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(Failure.auth(_getAuthErrorMessage(e.code)));
    } catch (e, st) {
      return Left(Failure.unknown(e, st));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    if (!isFirebaseAvailable) {
      return const Right(null);
    }
    try {
      await Future.wait([
        _firebaseAuth!.signOut(),
        _googleSignIn!.signOut(),
      ]);
      return const Right(null);
    } catch (e, st) {
      return Left(Failure.unknown(e, st));
    }
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    if (!isFirebaseAvailable) {
      return Left(Failure.auth('Firebase is not initialized. Please configure Firebase.'));
    }
    try {
      await _firebaseAuth!.sendPasswordResetEmail(email: email);
      return const Right(null);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(Failure.auth(_getAuthErrorMessage(e.code)));
    } catch (e, st) {
      return Left(Failure.unknown(e, st));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfile({
    String? fullName,
    String? phoneNumber,
    String? photoUrl,
  }) async {
    if (!isFirebaseAvailable) {
      return Left(Failure.auth('Firebase is not initialized. Please configure Firebase.'));
    }
    try {
      final firebaseUser = _firebaseAuth!.currentUser;
      if (firebaseUser == null) {
        return Left(Failure.auth('No user is currently signed in'));
      }

      // Update in Firebase Auth
      if (fullName != null) {
        await firebaseUser.updateDisplayName(fullName);
      }
      if (photoUrl != null) {
        await firebaseUser.updatePhotoURL(photoUrl);
      }

      // Get current user data
      final userDoc = await _firestore!.collection('users').doc(firebaseUser.uid).get();
      final currentUser = User.fromJson(userDoc.data()!);

      // Update in Firestore - only update fields that were provided
      User updatedUser = currentUser.copyWith(updatedAt: DateTime.now());

      if (fullName != null) {
        updatedUser = updatedUser.copyWith(fullName: fullName);
      }

      if (phoneNumber != null) {
        updatedUser = updatedUser.copyWith(phoneNumber: phoneNumber);
      }

      if (photoUrl != null) {
        updatedUser = updatedUser.copyWith(photoUrl: photoUrl);
      }

      await _saveUserToFirestore(updatedUser);

      return Right(updatedUser);
    } catch (e, st) {
      return Left(Failure.unknown(e, st));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    if (!isFirebaseAvailable) {
      return Left(Failure.auth('Firebase is not initialized. Please configure Firebase.'));
    }
    try {
      final firebaseUser = _firebaseAuth!.currentUser;
      if (firebaseUser == null) {
        return Left(Failure.auth('No user is currently signed in'));
      }

      // Delete user data from Firestore
      await _firestore!.collection('users').doc(firebaseUser.uid).delete();

      // Delete Firebase Auth account
      await firebaseUser.delete();

      return const Right(null);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(Failure.auth(_getAuthErrorMessage(e.code)));
    } catch (e, st) {
      return Left(Failure.unknown(e, st));
    }
  }

  @override
  Future<Either<Failure, void>> sendEmailVerification() async {
    if (!isFirebaseAvailable) {
      return const Left(Failure.auth('Firebase is not initialized. Please configure Firebase.'));
    }
    try {
      final firebaseUser = _firebaseAuth!.currentUser;
      if (firebaseUser == null) {
        return const Left(Failure.auth('No user is currently signed in'));
      }

      // Configure action code settings for deep linking
      // IMPORTANT: The URL must be an HTTP/HTTPS URL, not a custom scheme
      final actionCodeSettings = firebase_auth.ActionCodeSettings(
        url: 'https://divineseva.firebaseapp.com/__/auth/action?mode=verifyEmail',
        handleCodeInApp: true,
        iOSBundleId: 'com.example.toDoList2',
        androidPackageName: 'com.example.to_do_list_2',
        androidInstallApp: true,
        androidMinimumVersion: '1',
      );

      // Send email verification with continue URL
      await firebaseUser.sendEmailVerification(actionCodeSettings);

      return const Right(null);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(Failure.auth(_getAuthErrorMessage(e.code)));
    } catch (e, st) {
      return Left(Failure.unknown(e, st));
    }
  }

  @override
  Future<Either<Failure, bool>> checkEmailVerification() async {
    if (!isFirebaseAvailable) {
      return const Left(Failure.auth('Firebase is not initialized. Please configure Firebase.'));
    }
    try {
      final firebaseUser = _firebaseAuth!.currentUser;
      if (firebaseUser == null) {
        return const Left(Failure.auth('No user is currently signed in'));
      }

      // Reload user data to get the latest verification status
      await firebaseUser.reload();

      // Get the updated user
      final updatedUser = _firebaseAuth.currentUser;
      final isVerified = updatedUser?.emailVerified ?? false;

      // Update Firestore with verification status
      if (isVerified) {
        await _firestore!.collection('users').doc(firebaseUser.uid).update({
          'emailVerified': true,
          'updatedAt': DateTime.now().toIso8601String(),
        });
      }

      return Right(isVerified);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(Failure.auth(_getAuthErrorMessage(e.code)));
    } catch (e, st) {
      return Left(Failure.unknown(e, st));
    }
  }

  /// Convert Firebase User to domain User entity
  User _convertFirebaseUser(firebase_auth.User firebaseUser) {
    return User(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      fullName: firebaseUser.displayName ?? '',
      phoneNumber: firebaseUser.phoneNumber,
      photoUrl: firebaseUser.photoURL,
      emailVerified: firebaseUser.emailVerified,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      lastLoginAt: firebaseUser.metadata.lastSignInTime?.toDateTime(),
    );
  }

  /// Save user data to Firestore
  Future<void> _saveUserToFirestore(User user) async {
    if (!isFirebaseAvailable || _firestore == null) {
      return;
    }
    await _firestore.collection('users').doc(user.id).set(user.toJson());
  }

  /// Get user-friendly error message from Firebase Auth error code
  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Incorrect password provided.';
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'weak-password':
        return 'The password is too weak. Please use a stronger password.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but different sign-in credentials.';
      case 'invalid-credential':
        return 'The supplied credentials are incorrect.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      default:
        return 'An authentication error occurred: $code';
    }
  }
}

/// Extension to convert Firebase Timestamp to DateTime
extension TimestampExtension on DateTime? {
  DateTime? toDateTime() {
    return this;
  }
}
