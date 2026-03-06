/// Base class for all failures in the domain layer
/// Used with fpdart's Either<Failure, Success> pattern for error handling
sealed class Failure {
  const Failure();

  /// Pattern matching method for handling different failure types
  R when<R>({
    required R Function(String message) generic,
    required R Function(String message) network,
    required R Function(String message) database,
    required R Function(String message) auth,
    required R Function(String message) validation,
    required R Function(String? message) notFound,
    required R Function(String message) permissionDenied,
    required R Function(String message) cache,
    required R Function(String message) sync,
    required R Function(Object error, StackTrace? stackTrace) unknown,
  });

  // Factory constructors for convenience
  const factory Failure.generic(String message) = GenericFailure;
  const factory Failure.network(String message) = NetworkFailure;
  const factory Failure.database(String message) = DatabaseFailure;
  const factory Failure.auth(String message) = AuthFailure;
  const factory Failure.validation(String message) = ValidationFailure;
  const factory Failure.notFound([String? message]) = NotFoundFailure;
  const factory Failure.permissionDenied(String message) = PermissionDeniedFailure;
  const factory Failure.cache(String message) = CacheFailure;
  const factory Failure.sync(String message) = SyncFailure;
  const factory Failure.unknown(Object error, [StackTrace? stackTrace]) = UnknownFailure;
}

/// Generic failure for unexpected errors
class GenericFailure extends Failure {
  final String message;
  const GenericFailure(this.message);

  @override
  R when<R>({
    required R Function(String message) generic,
    required R Function(String message) network,
    required R Function(String message) database,
    required R Function(String message) auth,
    required R Function(String message) validation,
    required R Function(String? message) notFound,
    required R Function(String message) permissionDenied,
    required R Function(String message) cache,
    required R Function(String message) sync,
    required R Function(Object error, StackTrace? stackTrace) unknown,
  }) {
    return generic(message);
  }
}

/// Failure when a network request fails
class NetworkFailure extends Failure {
  final String message;
  const NetworkFailure(this.message);

  @override
  R when<R>({
    required R Function(String message) generic,
    required R Function(String message) network,
    required R Function(String message) database,
    required R Function(String message) auth,
    required R Function(String message) validation,
    required R Function(String? message) notFound,
    required R Function(String message) permissionDenied,
    required R Function(String message) cache,
    required R Function(String message) sync,
    required R Function(Object error, StackTrace? stackTrace) unknown,
  }) {
    return network(message);
  }
}

/// Failure when a database operation fails
class DatabaseFailure extends Failure {
  final String message;
  const DatabaseFailure(this.message);

  @override
  R when<R>({
    required R Function(String message) generic,
    required R Function(String message) network,
    required R Function(String message) database,
    required R Function(String message) auth,
    required R Function(String message) validation,
    required R Function(String? message) notFound,
    required R Function(String message) permissionDenied,
    required R Function(String message) cache,
    required R Function(String message) sync,
    required R Function(Object error, StackTrace? stackTrace) unknown,
  }) {
    return database(message);
  }
}

/// Failure when authentication fails
class AuthFailure extends Failure {
  final String message;
  const AuthFailure(this.message);

  @override
  R when<R>({
    required R Function(String message) generic,
    required R Function(String message) network,
    required R Function(String message) database,
    required R Function(String message) auth,
    required R Function(String message) validation,
    required R Function(String? message) notFound,
    required R Function(String message) permissionDenied,
    required R Function(String message) cache,
    required R Function(String message) sync,
    required R Function(Object error, StackTrace? stackTrace) unknown,
  }) {
    return auth(message);
  }
}

/// Failure when validation fails
class ValidationFailure extends Failure {
  final String message;
  const ValidationFailure(this.message);

  @override
  R when<R>({
    required R Function(String message) generic,
    required R Function(String message) network,
    required R Function(String message) database,
    required R Function(String message) auth,
    required R Function(String message) validation,
    required R Function(String? message) notFound,
    required R Function(String message) permissionDenied,
    required R Function(String message) cache,
    required R Function(String message) sync,
    required R Function(Object error, StackTrace? stackTrace) unknown,
  }) {
    return validation(message);
  }
}

/// Failure when data is not found
class NotFoundFailure extends Failure {
  final String? message;
  const NotFoundFailure([this.message]);

  @override
  R when<R>({
    required R Function(String message) generic,
    required R Function(String message) network,
    required R Function(String message) database,
    required R Function(String message) auth,
    required R Function(String message) validation,
    required R Function(String? message) notFound,
    required R Function(String message) permissionDenied,
    required R Function(String message) cache,
    required R Function(String message) sync,
    required R Function(Object error, StackTrace? stackTrace) unknown,
  }) {
    return notFound(message);
  }
}

/// Failure when there's a permission issue
class PermissionDeniedFailure extends Failure {
  final String message;
  const PermissionDeniedFailure(this.message);

  @override
  R when<R>({
    required R Function(String message) generic,
    required R Function(String message) network,
    required R Function(String message) database,
    required R Function(String message) auth,
    required R Function(String message) validation,
    required R Function(String? message) notFound,
    required R Function(String message) permissionDenied,
    required R Function(String message) cache,
    required R Function(String message) sync,
    required R Function(Object error, StackTrace? stackTrace) unknown,
  }) {
    return permissionDenied(message);
  }
}

/// Failure when there's a cache error
class CacheFailure extends Failure {
  final String message;
  const CacheFailure(this.message);

  @override
  R when<R>({
    required R Function(String message) generic,
    required R Function(String message) network,
    required R Function(String message) database,
    required R Function(String message) auth,
    required R Function(String message) validation,
    required R Function(String? message) notFound,
    required R Function(String message) permissionDenied,
    required R Function(String message) cache,
    required R Function(String message) sync,
    required R Function(Object error, StackTrace? stackTrace) unknown,
  }) {
    return cache(message);
  }
}

/// Failure when sync operation fails
class SyncFailure extends Failure {
  final String message;
  const SyncFailure(this.message);

  @override
  R when<R>({
    required R Function(String message) generic,
    required R Function(String message) network,
    required R Function(String message) database,
    required R Function(String message) auth,
    required R Function(String message) validation,
    required R Function(String? message) notFound,
    required R Function(String message) permissionDenied,
    required R Function(String message) cache,
    required R Function(String message) sync,
    required R Function(Object error, StackTrace? stackTrace) unknown,
  }) {
    return sync(message);
  }
}

/// Failure for unknown/unexpected errors
class UnknownFailure extends Failure {
  final Object error;
  final StackTrace? stackTrace;
  const UnknownFailure(this.error, [this.stackTrace]);

  @override
  R when<R>({
    required R Function(String message) generic,
    required R Function(String message) network,
    required R Function(String message) database,
    required R Function(String message) auth,
    required R Function(String message) validation,
    required R Function(String? message) notFound,
    required R Function(String message) permissionDenied,
    required R Function(String message) cache,
    required R Function(String message) sync,
    required R Function(Object error, StackTrace? stackTrace) unknown,
  }) {
    return unknown(error, stackTrace);
  }
}
