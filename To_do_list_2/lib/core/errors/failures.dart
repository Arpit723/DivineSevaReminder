import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Base class for all failures
/// Failures represent error cases in the application
/// Unlike exceptions, failures are expected and handled gracefully
@freezed
class Failure with _$Failure {
  /// Generic failure with a message
  const factory Failure.generic(String message) = GenericFailure;

  /// Network-related failure
  const factory Failure.network(String message) = NetworkFailure;

  /// Database operation failure
  const factory Failure.database(String message) = DatabaseFailure;

  /// Authentication failure
  const factory Failure.auth(String message) = AuthFailure;

  /// Validation failure
  const factory Failure.validation(String message) = ValidationFailure;

  /// Not found failure
  const factory Failure.notFound([String? message]) = NotFoundFailure;

  /// Permission denied failure
  const factory Failure.permissionDenied(String message) =
      PermissionDeniedFailure;

  /// Cache failure
  const factory Failure.cache(String message) = CacheFailure;

  /// Sync failure
  const factory Failure.sync(String message) = SyncFailure;

  /// Unknown/unexpected failure
  const factory Failure.unknown([Object? error, StackTrace? stackTrace]) =
      UnknownFailure;
}
