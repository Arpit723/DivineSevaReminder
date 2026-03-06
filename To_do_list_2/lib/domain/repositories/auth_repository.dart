import 'package:fpdart/fpdart.dart';
import '../entities/user/user.dart';
import '../../core/errors/failures.dart';

/// Repository interface for Authentication operations
abstract class AuthRepository {
  /// Stream of authentication state changes
  /// Emits the current user or null if not authenticated
  Stream<Either<Failure, User?>> get authStateChanges;

  /// Get the current authenticated user (null if not authenticated)
  Future<Either<Failure, User?>> getCurrentUser();

  /// Sign in with email and password
  Future<Either<Failure, User>> signInWithEmail({
    required String email,
    required String password,
  });

  /// Sign up with email and password
  Future<Either<Failure, User>> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
  });

  /// Sign in with Google
  Future<Either<Failure, User>> signInWithGoogle();

  /// Sign out the current user
  Future<Either<Failure, void>> signOut();

  /// Send password reset email
  Future<Either<Failure, void>> sendPasswordResetEmail(String email);

  /// Update user profile
  Future<Either<Failure, User>> updateProfile({
    String? fullName,
    String? phoneNumber,
    String? photoUrl,
  });

  /// Delete user account
  Future<Either<Failure, void>> deleteAccount();

  /// Send email verification to the current user
  Future<Either<Failure, void>> sendEmailVerification();

  /// Check if current user's email is verified
  /// Reloads the user data from Firebase to get the latest verification status
  Future<Either<Failure, bool>> checkEmailVerification();
}
