// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firebaseAuthServiceHash() =>
    r'932f2366f20e06e26bf8aba16cd27209742e9bb9';

/// Provider for FirebaseAuthService
///
/// Copied from [firebaseAuthService].
@ProviderFor(firebaseAuthService)
final firebaseAuthServiceProvider =
    AutoDisposeProvider<FirebaseAuthService>.internal(
  firebaseAuthService,
  name: r'firebaseAuthServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firebaseAuthServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FirebaseAuthServiceRef = AutoDisposeProviderRef<FirebaseAuthService>;
String _$authRepositoryHash() => r'38640e0d746912a076713555c1565128b5c7572a';

/// Provider for AuthRepository
///
/// Copied from [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = AutoDisposeProvider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRepositoryRef = AutoDisposeProviderRef<AuthRepository>;
String _$authStateHash() => r'6f6622130fdc3656be43c713bfda53b003b7d1bd';

/// Provider for current authentication state
///
/// Copied from [authState].
@ProviderFor(authState)
final authStateProvider =
    AutoDisposeStreamProvider<Either<Failure, User?>>.internal(
  authState,
  name: r'authStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthStateRef = AutoDisposeStreamProviderRef<Either<Failure, User?>>;
String _$getCurrentUserHash() => r'f6121708fa22e4d1c44a7d9c13ad50bf58475c96';

/// Provider for getting current user once (not a stream)
///
/// Copied from [getCurrentUser].
@ProviderFor(getCurrentUser)
final getCurrentUserProvider =
    AutoDisposeFutureProvider<Either<Failure, User?>>.internal(
  getCurrentUser,
  name: r'getCurrentUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getCurrentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetCurrentUserRef
    = AutoDisposeFutureProviderRef<Either<Failure, User?>>;
String _$isAuthenticatedHash() => r'94b0a3d521c85b0f091a1470c7dee76c14138fd7';

/// StreamProvider to check if user is authenticated
///
/// Copied from [isAuthenticated].
@ProviderFor(isAuthenticated)
final isAuthenticatedProvider = AutoDisposeStreamProvider<bool>.internal(
  isAuthenticated,
  name: r'isAuthenticatedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAuthenticatedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsAuthenticatedRef = AutoDisposeStreamProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
