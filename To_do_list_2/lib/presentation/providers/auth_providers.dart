import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart';
import '../../data/datasources/remote/firebase/firebase_auth_service.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user/user.dart';
import '../../core/errors/failures.dart';

part 'auth_providers.g.dart';

/// Provider for FirebaseAuthService
@riverpod
FirebaseAuthService firebaseAuthService(FirebaseAuthServiceRef ref) {
  return FirebaseAuthService();
}

/// Provider for AuthRepository
@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return ref.watch(firebaseAuthServiceProvider);
}

/// Provider for current authentication state
@riverpod
Stream<Either<Failure, User?>> authState(AuthStateRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.authStateChanges;
}

/// Provider for getting current user once (not a stream)
@riverpod
Future<Either<Failure, User?>> getCurrentUser(GetCurrentUserRef ref) {
  final repository = ref.read(authRepositoryProvider);
  return repository.getCurrentUser();
}

/// StreamProvider to check if user is authenticated
@riverpod
Stream<bool> isAuthenticated(IsAuthenticatedRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.authStateChanges.map((state) => state.fold(
        (failure) => false,
        (user) => user != null,
      ));
}
