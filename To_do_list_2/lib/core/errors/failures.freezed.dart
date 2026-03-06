// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Failure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) generic,
    required TResult Function(String message) network,
    required TResult Function(String message) database,
    required TResult Function(String message) auth,
    required TResult Function(String message) validation,
    required TResult Function(String? message) notFound,
    required TResult Function(String message) permissionDenied,
    required TResult Function(String message) cache,
    required TResult Function(String message) sync,
    required TResult Function(Object? error, StackTrace? stackTrace) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? generic,
    TResult? Function(String message)? network,
    TResult? Function(String message)? database,
    TResult? Function(String message)? auth,
    TResult? Function(String message)? validation,
    TResult? Function(String? message)? notFound,
    TResult? Function(String message)? permissionDenied,
    TResult? Function(String message)? cache,
    TResult? Function(String message)? sync,
    TResult? Function(Object? error, StackTrace? stackTrace)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? generic,
    TResult Function(String message)? network,
    TResult Function(String message)? database,
    TResult Function(String message)? auth,
    TResult Function(String message)? validation,
    TResult Function(String? message)? notFound,
    TResult Function(String message)? permissionDenied,
    TResult Function(String message)? cache,
    TResult Function(String message)? sync,
    TResult Function(Object? error, StackTrace? stackTrace)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenericFailure value) generic,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(DatabaseFailure value) database,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(PermissionDeniedFailure value) permissionDenied,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(SyncFailure value) sync,
    required TResult Function(UnknownFailure value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenericFailure value)? generic,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(DatabaseFailure value)? database,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(PermissionDeniedFailure value)? permissionDenied,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(SyncFailure value)? sync,
    TResult? Function(UnknownFailure value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenericFailure value)? generic,
    TResult Function(NetworkFailure value)? network,
    TResult Function(DatabaseFailure value)? database,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(PermissionDeniedFailure value)? permissionDenied,
    TResult Function(CacheFailure value)? cache,
    TResult Function(SyncFailure value)? sync,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res, Failure>;
}

/// @nodoc
class _$FailureCopyWithImpl<$Res, $Val extends Failure>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$GenericFailureImplCopyWith<$Res> {
  factory _$$GenericFailureImplCopyWith(_$GenericFailureImpl value,
          $Res Function(_$GenericFailureImpl) then) =
      __$$GenericFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$GenericFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$GenericFailureImpl>
    implements _$$GenericFailureImplCopyWith<$Res> {
  __$$GenericFailureImplCopyWithImpl(
      _$GenericFailureImpl _value, $Res Function(_$GenericFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$GenericFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GenericFailureImpl implements GenericFailure {
  const _$GenericFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.generic(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenericFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GenericFailureImplCopyWith<_$GenericFailureImpl> get copyWith =>
      __$$GenericFailureImplCopyWithImpl<_$GenericFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) generic,
    required TResult Function(String message) network,
    required TResult Function(String message) database,
    required TResult Function(String message) auth,
    required TResult Function(String message) validation,
    required TResult Function(String? message) notFound,
    required TResult Function(String message) permissionDenied,
    required TResult Function(String message) cache,
    required TResult Function(String message) sync,
    required TResult Function(Object? error, StackTrace? stackTrace) unknown,
  }) {
    return generic(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? generic,
    TResult? Function(String message)? network,
    TResult? Function(String message)? database,
    TResult? Function(String message)? auth,
    TResult? Function(String message)? validation,
    TResult? Function(String? message)? notFound,
    TResult? Function(String message)? permissionDenied,
    TResult? Function(String message)? cache,
    TResult? Function(String message)? sync,
    TResult? Function(Object? error, StackTrace? stackTrace)? unknown,
  }) {
    return generic?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? generic,
    TResult Function(String message)? network,
    TResult Function(String message)? database,
    TResult Function(String message)? auth,
    TResult Function(String message)? validation,
    TResult Function(String? message)? notFound,
    TResult Function(String message)? permissionDenied,
    TResult Function(String message)? cache,
    TResult Function(String message)? sync,
    TResult Function(Object? error, StackTrace? stackTrace)? unknown,
    required TResult orElse(),
  }) {
    if (generic != null) {
      return generic(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenericFailure value) generic,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(DatabaseFailure value) database,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(PermissionDeniedFailure value) permissionDenied,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(SyncFailure value) sync,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return generic(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenericFailure value)? generic,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(DatabaseFailure value)? database,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(PermissionDeniedFailure value)? permissionDenied,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(SyncFailure value)? sync,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return generic?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenericFailure value)? generic,
    TResult Function(NetworkFailure value)? network,
    TResult Function(DatabaseFailure value)? database,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(PermissionDeniedFailure value)? permissionDenied,
    TResult Function(CacheFailure value)? cache,
    TResult Function(SyncFailure value)? sync,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (generic != null) {
      return generic(this);
    }
    return orElse();
  }
}

abstract class GenericFailure implements Failure {
  const factory GenericFailure(final String message) = _$GenericFailureImpl;

  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GenericFailureImplCopyWith<_$GenericFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NetworkFailureImplCopyWith<$Res> {
  factory _$$NetworkFailureImplCopyWith(_$NetworkFailureImpl value,
          $Res Function(_$NetworkFailureImpl) then) =
      __$$NetworkFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NetworkFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NetworkFailureImpl>
    implements _$$NetworkFailureImplCopyWith<$Res> {
  __$$NetworkFailureImplCopyWithImpl(
      _$NetworkFailureImpl _value, $Res Function(_$NetworkFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$NetworkFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$NetworkFailureImpl implements NetworkFailure {
  const _$NetworkFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.network(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      __$$NetworkFailureImplCopyWithImpl<_$NetworkFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) generic,
    required TResult Function(String message) network,
    required TResult Function(String message) database,
    required TResult Function(String message) auth,
    required TResult Function(String message) validation,
    required TResult Function(String? message) notFound,
    required TResult Function(String message) permissionDenied,
    required TResult Function(String message) cache,
    required TResult Function(String message) sync,
    required TResult Function(Object? error, StackTrace? stackTrace) unknown,
  }) {
    return network(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? generic,
    TResult? Function(String message)? network,
    TResult? Function(String message)? database,
    TResult? Function(String message)? auth,
    TResult? Function(String message)? validation,
    TResult? Function(String? message)? notFound,
    TResult? Function(String message)? permissionDenied,
    TResult? Function(String message)? cache,
    TResult? Function(String message)? sync,
    TResult? Function(Object? error, StackTrace? stackTrace)? unknown,
  }) {
    return network?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? generic,
    TResult Function(String message)? network,
    TResult Function(String message)? database,
    TResult Function(String message)? auth,
    TResult Function(String message)? validation,
    TResult Function(String? message)? notFound,
    TResult Function(String message)? permissionDenied,
    TResult Function(String message)? cache,
    TResult Function(String message)? sync,
    TResult Function(Object? error, StackTrace? stackTrace)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenericFailure value) generic,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(DatabaseFailure value) database,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(PermissionDeniedFailure value) permissionDenied,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(SyncFailure value) sync,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenericFailure value)? generic,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(DatabaseFailure value)? database,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(PermissionDeniedFailure value)? permissionDenied,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(SyncFailure value)? sync,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenericFailure value)? generic,
    TResult Function(NetworkFailure value)? network,
    TResult Function(DatabaseFailure value)? database,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(PermissionDeniedFailure value)? permissionDenied,
    TResult Function(CacheFailure value)? cache,
    TResult Function(SyncFailure value)? sync,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class NetworkFailure implements Failure {
  const factory NetworkFailure(final String message) = _$NetworkFailureImpl;

  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DatabaseFailureImplCopyWith<$Res> {
  factory _$$DatabaseFailureImplCopyWith(_$DatabaseFailureImpl value,
          $Res Function(_$DatabaseFailureImpl) then) =
      __$$DatabaseFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$DatabaseFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$DatabaseFailureImpl>
    implements _$$DatabaseFailureImplCopyWith<$Res> {
  __$$DatabaseFailureImplCopyWithImpl(
      _$DatabaseFailureImpl _value, $Res Function(_$DatabaseFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$DatabaseFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DatabaseFailureImpl implements DatabaseFailure {
  const _$DatabaseFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.database(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatabaseFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DatabaseFailureImplCopyWith<_$DatabaseFailureImpl> get copyWith =>
      __$$DatabaseFailureImplCopyWithImpl<_$DatabaseFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) generic,
    required TResult Function(String message) network,
    required TResult Function(String message) database,
    required TResult Function(String message) auth,
    required TResult Function(String message) validation,
    required TResult Function(String? message) notFound,
    required TResult Function(String message) permissionDenied,
    required TResult Function(String message) cache,
    required TResult Function(String message) sync,
    required TResult Function(Object? error, StackTrace? stackTrace) unknown,
  }) {
    return database(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? generic,
    TResult? Function(String message)? network,
    TResult? Function(String message)? database,
    TResult? Function(String message)? auth,
    TResult? Function(String message)? validation,
    TResult? Function(String? message)? notFound,
    TResult? Function(String message)? permissionDenied,
    TResult? Function(String message)? cache,
    TResult? Function(String message)? sync,
    TResult? Function(Object? error, StackTrace? stackTrace)? unknown,
  }) {
    return database?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? generic,
    TResult Function(String message)? network,
    TResult Function(String message)? database,
    TResult Function(String message)? auth,
    TResult Function(String message)? validation,
    TResult Function(String? message)? notFound,
    TResult Function(String message)? permissionDenied,
    TResult Function(String message)? cache,
    TResult Function(String message)? sync,
    TResult Function(Object? error, StackTrace? stackTrace)? unknown,
    required TResult orElse(),
  }) {
    if (database != null) {
      return database(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenericFailure value) generic,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(DatabaseFailure value) database,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(PermissionDeniedFailure value) permissionDenied,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(SyncFailure value) sync,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return database(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenericFailure value)? generic,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(DatabaseFailure value)? database,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(PermissionDeniedFailure value)? permissionDenied,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(SyncFailure value)? sync,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return database?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenericFailure value)? generic,
    TResult Function(NetworkFailure value)? network,
    TResult Function(DatabaseFailure value)? database,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(PermissionDeniedFailure value)? permissionDenied,
    TResult Function(CacheFailure value)? cache,
    TResult Function(SyncFailure value)? sync,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (database != null) {
      return database(this);
    }
    return orElse();
  }
}

abstract class DatabaseFailure implements Failure {
  const factory DatabaseFailure(final String message) = _$DatabaseFailureImpl;

  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DatabaseFailureImplCopyWith<_$DatabaseFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthFailureImplCopyWith<$Res> {
  factory _$$AuthFailureImplCopyWith(
          _$AuthFailureImpl value, $Res Function(_$AuthFailureImpl) then) =
      __$$AuthFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$AuthFailureImpl>
    implements _$$AuthFailureImplCopyWith<$Res> {
  __$$AuthFailureImplCopyWithImpl(
      _$AuthFailureImpl _value, $Res Function(_$AuthFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$AuthFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthFailureImpl implements AuthFailure {
  const _$AuthFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.auth(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthFailureImplCopyWith<_$AuthFailureImpl> get copyWith =>
      __$$AuthFailureImplCopyWithImpl<_$AuthFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) generic,
    required TResult Function(String message) network,
    required TResult Function(String message) database,
    required TResult Function(String message) auth,
    required TResult Function(String message) validation,
    required TResult Function(String? message) notFound,
    required TResult Function(String message) permissionDenied,
    required TResult Function(String message) cache,
    required TResult Function(String message) sync,
    required TResult Function(Object? error, StackTrace? stackTrace) unknown,
  }) {
    return auth(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? generic,
    TResult? Function(String message)? network,
    TResult? Function(String message)? database,
    TResult? Function(String message)? auth,
    TResult? Function(String message)? validation,
    TResult? Function(String? message)? notFound,
    TResult? Function(String message)? permissionDenied,
    TResult? Function(String message)? cache,
    TResult? Function(String message)? sync,
    TResult? Function(Object? error, StackTrace? stackTrace)? unknown,
  }) {
    return auth?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? generic,
    TResult Function(String message)? network,
    TResult Function(String message)? database,
    TResult Function(String message)? auth,
    TResult Function(String message)? validation,
    TResult Function(String? message)? notFound,
    TResult Function(String message)? permissionDenied,
    TResult Function(String message)? cache,
    TResult Function(String message)? sync,
    TResult Function(Object? error, StackTrace? stackTrace)? unknown,
    required TResult orElse(),
  }) {
    if (auth != null) {
      return auth(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenericFailure value) generic,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(DatabaseFailure value) database,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(PermissionDeniedFailure value) permissionDenied,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(SyncFailure value) sync,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return auth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenericFailure value)? generic,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(DatabaseFailure value)? database,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(PermissionDeniedFailure value)? permissionDenied,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(SyncFailure value)? sync,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return auth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenericFailure value)? generic,
    TResult Function(NetworkFailure value)? network,
    TResult Function(DatabaseFailure value)? database,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(PermissionDeniedFailure value)? permissionDenied,
    TResult Function(CacheFailure value)? cache,
    TResult Function(SyncFailure value)? sync,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (auth != null) {
      return auth(this);
    }
    return orElse();
  }
}

abstract class AuthFailure implements Failure {
  const factory AuthFailure(final String message) = _$AuthFailureImpl;

  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthFailureImplCopyWith<_$AuthFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidationFailureImplCopyWith<$Res> {
  factory _$$ValidationFailureImplCopyWith(_$ValidationFailureImpl value,
          $Res Function(_$ValidationFailureImpl) then) =
      __$$ValidationFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ValidationFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ValidationFailureImpl>
    implements _$$ValidationFailureImplCopyWith<$Res> {
  __$$ValidationFailureImplCopyWithImpl(_$ValidationFailureImpl _value,
      $Res Function(_$ValidationFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ValidationFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ValidationFailureImpl implements ValidationFailure {
  const _$ValidationFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.validation(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      __$$ValidationFailureImplCopyWithImpl<_$ValidationFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) generic,
    required TResult Function(String message) network,
    required TResult Function(String message) database,
    required TResult Function(String message) auth,
    required TResult Function(String message) validation,
    required TResult Function(String? message) notFound,
    required TResult Function(String message) permissionDenied,
    required TResult Function(String message) cache,
    required TResult Function(String message) sync,
    required TResult Function(Object? error, StackTrace? stackTrace) unknown,
  }) {
    return validation(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? generic,
    TResult? Function(String message)? network,
    TResult? Function(String message)? database,
    TResult? Function(String message)? auth,
    TResult? Function(String message)? validation,
    TResult? Function(String? message)? notFound,
    TResult? Function(String message)? permissionDenied,
    TResult? Function(String message)? cache,
    TResult? Function(String message)? sync,
    TResult? Function(Object? error, StackTrace? stackTrace)? unknown,
  }) {
    return validation?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? generic,
    TResult Function(String message)? network,
    TResult Function(String message)? database,
    TResult Function(String message)? auth,
    TResult Function(String message)? validation,
    TResult Function(String? message)? notFound,
    TResult Function(String message)? permissionDenied,
    TResult Function(String message)? cache,
    TResult Function(String message)? sync,
    TResult Function(Object? error, StackTrace? stackTrace)? unknown,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenericFailure value) generic,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(DatabaseFailure value) database,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(PermissionDeniedFailure value) permissionDenied,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(SyncFailure value) sync,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return validation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenericFailure value)? generic,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(DatabaseFailure value)? database,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(PermissionDeniedFailure value)? permissionDenied,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(SyncFailure value)? sync,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return validation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenericFailure value)? generic,
    TResult Function(NetworkFailure value)? network,
    TResult Function(DatabaseFailure value)? database,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(PermissionDeniedFailure value)? permissionDenied,
    TResult Function(CacheFailure value)? cache,
    TResult Function(SyncFailure value)? sync,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(this);
    }
    return orElse();
  }
}

abstract class ValidationFailure implements Failure {
  const factory ValidationFailure(final String message) =
      _$ValidationFailureImpl;

  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NotFoundFailureImplCopyWith<$Res> {
  factory _$$NotFoundFailureImplCopyWith(_$NotFoundFailureImpl value,
          $Res Function(_$NotFoundFailureImpl) then) =
      __$$NotFoundFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$NotFoundFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NotFoundFailureImpl>
    implements _$$NotFoundFailureImplCopyWith<$Res> {
  __$$NotFoundFailureImplCopyWithImpl(
      _$NotFoundFailureImpl _value, $Res Function(_$NotFoundFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$NotFoundFailureImpl(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NotFoundFailureImpl implements NotFoundFailure {
  const _$NotFoundFailureImpl([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'Failure.notFound(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotFoundFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotFoundFailureImplCopyWith<_$NotFoundFailureImpl> get copyWith =>
      __$$NotFoundFailureImplCopyWithImpl<_$NotFoundFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) generic,
    required TResult Function(String message) network,
    required TResult Function(String message) database,
    required TResult Function(String message) auth,
    required TResult Function(String message) validation,
    required TResult Function(String? message) notFound,
    required TResult Function(String message) permissionDenied,
    required TResult Function(String message) cache,
    required TResult Function(String message) sync,
    required TResult Function(Object? error, StackTrace? stackTrace) unknown,
  }) {
    return notFound(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? generic,
    TResult? Function(String message)? network,
    TResult? Function(String message)? database,
    TResult? Function(String message)? auth,
    TResult? Function(String message)? validation,
    TResult? Function(String? message)? notFound,
    TResult? Function(String message)? permissionDenied,
    TResult? Function(String message)? cache,
    TResult? Function(String message)? sync,
    TResult? Function(Object? error, StackTrace? stackTrace)? unknown,
  }) {
    return notFound?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? generic,
    TResult Function(String message)? network,
    TResult Function(String message)? database,
    TResult Function(String message)? auth,
    TResult Function(String message)? validation,
    TResult Function(String? message)? notFound,
    TResult Function(String message)? permissionDenied,
    TResult Function(String message)? cache,
    TResult Function(String message)? sync,
    TResult Function(Object? error, StackTrace? stackTrace)? unknown,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenericFailure value) generic,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(DatabaseFailure value) database,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(PermissionDeniedFailure value) permissionDenied,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(SyncFailure value) sync,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return notFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenericFailure value)? generic,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(DatabaseFailure value)? database,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(PermissionDeniedFailure value)? permissionDenied,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(SyncFailure value)? sync,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return notFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenericFailure value)? generic,
    TResult Function(NetworkFailure value)? network,
    TResult Function(DatabaseFailure value)? database,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(PermissionDeniedFailure value)? permissionDenied,
    TResult Function(CacheFailure value)? cache,
    TResult Function(SyncFailure value)? sync,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(this);
    }
    return orElse();
  }
}

abstract class NotFoundFailure implements Failure {
  const factory NotFoundFailure([final String? message]) =
      _$NotFoundFailureImpl;

  String? get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotFoundFailureImplCopyWith<_$NotFoundFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PermissionDeniedFailureImplCopyWith<$Res> {
  factory _$$PermissionDeniedFailureImplCopyWith(
          _$PermissionDeniedFailureImpl value,
          $Res Function(_$PermissionDeniedFailureImpl) then) =
      __$$PermissionDeniedFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$PermissionDeniedFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$PermissionDeniedFailureImpl>
    implements _$$PermissionDeniedFailureImplCopyWith<$Res> {
  __$$PermissionDeniedFailureImplCopyWithImpl(
      _$PermissionDeniedFailureImpl _value,
      $Res Function(_$PermissionDeniedFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$PermissionDeniedFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PermissionDeniedFailureImpl implements PermissionDeniedFailure {
  const _$PermissionDeniedFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.permissionDenied(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionDeniedFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionDeniedFailureImplCopyWith<_$PermissionDeniedFailureImpl>
      get copyWith => __$$PermissionDeniedFailureImplCopyWithImpl<
          _$PermissionDeniedFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) generic,
    required TResult Function(String message) network,
    required TResult Function(String message) database,
    required TResult Function(String message) auth,
    required TResult Function(String message) validation,
    required TResult Function(String? message) notFound,
    required TResult Function(String message) permissionDenied,
    required TResult Function(String message) cache,
    required TResult Function(String message) sync,
    required TResult Function(Object? error, StackTrace? stackTrace) unknown,
  }) {
    return permissionDenied(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? generic,
    TResult? Function(String message)? network,
    TResult? Function(String message)? database,
    TResult? Function(String message)? auth,
    TResult? Function(String message)? validation,
    TResult? Function(String? message)? notFound,
    TResult? Function(String message)? permissionDenied,
    TResult? Function(String message)? cache,
    TResult? Function(String message)? sync,
    TResult? Function(Object? error, StackTrace? stackTrace)? unknown,
  }) {
    return permissionDenied?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? generic,
    TResult Function(String message)? network,
    TResult Function(String message)? database,
    TResult Function(String message)? auth,
    TResult Function(String message)? validation,
    TResult Function(String? message)? notFound,
    TResult Function(String message)? permissionDenied,
    TResult Function(String message)? cache,
    TResult Function(String message)? sync,
    TResult Function(Object? error, StackTrace? stackTrace)? unknown,
    required TResult orElse(),
  }) {
    if (permissionDenied != null) {
      return permissionDenied(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenericFailure value) generic,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(DatabaseFailure value) database,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(PermissionDeniedFailure value) permissionDenied,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(SyncFailure value) sync,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return permissionDenied(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenericFailure value)? generic,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(DatabaseFailure value)? database,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(PermissionDeniedFailure value)? permissionDenied,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(SyncFailure value)? sync,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return permissionDenied?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenericFailure value)? generic,
    TResult Function(NetworkFailure value)? network,
    TResult Function(DatabaseFailure value)? database,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(PermissionDeniedFailure value)? permissionDenied,
    TResult Function(CacheFailure value)? cache,
    TResult Function(SyncFailure value)? sync,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (permissionDenied != null) {
      return permissionDenied(this);
    }
    return orElse();
  }
}

abstract class PermissionDeniedFailure implements Failure {
  const factory PermissionDeniedFailure(final String message) =
      _$PermissionDeniedFailureImpl;

  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PermissionDeniedFailureImplCopyWith<_$PermissionDeniedFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CacheFailureImplCopyWith<$Res> {
  factory _$$CacheFailureImplCopyWith(
          _$CacheFailureImpl value, $Res Function(_$CacheFailureImpl) then) =
      __$$CacheFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$CacheFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$CacheFailureImpl>
    implements _$$CacheFailureImplCopyWith<$Res> {
  __$$CacheFailureImplCopyWithImpl(
      _$CacheFailureImpl _value, $Res Function(_$CacheFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$CacheFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CacheFailureImpl implements CacheFailure {
  const _$CacheFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.cache(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CacheFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CacheFailureImplCopyWith<_$CacheFailureImpl> get copyWith =>
      __$$CacheFailureImplCopyWithImpl<_$CacheFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) generic,
    required TResult Function(String message) network,
    required TResult Function(String message) database,
    required TResult Function(String message) auth,
    required TResult Function(String message) validation,
    required TResult Function(String? message) notFound,
    required TResult Function(String message) permissionDenied,
    required TResult Function(String message) cache,
    required TResult Function(String message) sync,
    required TResult Function(Object? error, StackTrace? stackTrace) unknown,
  }) {
    return cache(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? generic,
    TResult? Function(String message)? network,
    TResult? Function(String message)? database,
    TResult? Function(String message)? auth,
    TResult? Function(String message)? validation,
    TResult? Function(String? message)? notFound,
    TResult? Function(String message)? permissionDenied,
    TResult? Function(String message)? cache,
    TResult? Function(String message)? sync,
    TResult? Function(Object? error, StackTrace? stackTrace)? unknown,
  }) {
    return cache?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? generic,
    TResult Function(String message)? network,
    TResult Function(String message)? database,
    TResult Function(String message)? auth,
    TResult Function(String message)? validation,
    TResult Function(String? message)? notFound,
    TResult Function(String message)? permissionDenied,
    TResult Function(String message)? cache,
    TResult Function(String message)? sync,
    TResult Function(Object? error, StackTrace? stackTrace)? unknown,
    required TResult orElse(),
  }) {
    if (cache != null) {
      return cache(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenericFailure value) generic,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(DatabaseFailure value) database,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(PermissionDeniedFailure value) permissionDenied,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(SyncFailure value) sync,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return cache(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenericFailure value)? generic,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(DatabaseFailure value)? database,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(PermissionDeniedFailure value)? permissionDenied,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(SyncFailure value)? sync,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return cache?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenericFailure value)? generic,
    TResult Function(NetworkFailure value)? network,
    TResult Function(DatabaseFailure value)? database,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(PermissionDeniedFailure value)? permissionDenied,
    TResult Function(CacheFailure value)? cache,
    TResult Function(SyncFailure value)? sync,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (cache != null) {
      return cache(this);
    }
    return orElse();
  }
}

abstract class CacheFailure implements Failure {
  const factory CacheFailure(final String message) = _$CacheFailureImpl;

  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CacheFailureImplCopyWith<_$CacheFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SyncFailureImplCopyWith<$Res> {
  factory _$$SyncFailureImplCopyWith(
          _$SyncFailureImpl value, $Res Function(_$SyncFailureImpl) then) =
      __$$SyncFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SyncFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$SyncFailureImpl>
    implements _$$SyncFailureImplCopyWith<$Res> {
  __$$SyncFailureImplCopyWithImpl(
      _$SyncFailureImpl _value, $Res Function(_$SyncFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$SyncFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SyncFailureImpl implements SyncFailure {
  const _$SyncFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.sync(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncFailureImplCopyWith<_$SyncFailureImpl> get copyWith =>
      __$$SyncFailureImplCopyWithImpl<_$SyncFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) generic,
    required TResult Function(String message) network,
    required TResult Function(String message) database,
    required TResult Function(String message) auth,
    required TResult Function(String message) validation,
    required TResult Function(String? message) notFound,
    required TResult Function(String message) permissionDenied,
    required TResult Function(String message) cache,
    required TResult Function(String message) sync,
    required TResult Function(Object? error, StackTrace? stackTrace) unknown,
  }) {
    return sync(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? generic,
    TResult? Function(String message)? network,
    TResult? Function(String message)? database,
    TResult? Function(String message)? auth,
    TResult? Function(String message)? validation,
    TResult? Function(String? message)? notFound,
    TResult? Function(String message)? permissionDenied,
    TResult? Function(String message)? cache,
    TResult? Function(String message)? sync,
    TResult? Function(Object? error, StackTrace? stackTrace)? unknown,
  }) {
    return sync?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? generic,
    TResult Function(String message)? network,
    TResult Function(String message)? database,
    TResult Function(String message)? auth,
    TResult Function(String message)? validation,
    TResult Function(String? message)? notFound,
    TResult Function(String message)? permissionDenied,
    TResult Function(String message)? cache,
    TResult Function(String message)? sync,
    TResult Function(Object? error, StackTrace? stackTrace)? unknown,
    required TResult orElse(),
  }) {
    if (sync != null) {
      return sync(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenericFailure value) generic,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(DatabaseFailure value) database,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(PermissionDeniedFailure value) permissionDenied,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(SyncFailure value) sync,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return sync(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenericFailure value)? generic,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(DatabaseFailure value)? database,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(PermissionDeniedFailure value)? permissionDenied,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(SyncFailure value)? sync,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return sync?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenericFailure value)? generic,
    TResult Function(NetworkFailure value)? network,
    TResult Function(DatabaseFailure value)? database,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(PermissionDeniedFailure value)? permissionDenied,
    TResult Function(CacheFailure value)? cache,
    TResult Function(SyncFailure value)? sync,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (sync != null) {
      return sync(this);
    }
    return orElse();
  }
}

abstract class SyncFailure implements Failure {
  const factory SyncFailure(final String message) = _$SyncFailureImpl;

  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncFailureImplCopyWith<_$SyncFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownFailureImplCopyWith<$Res> {
  factory _$$UnknownFailureImplCopyWith(_$UnknownFailureImpl value,
          $Res Function(_$UnknownFailureImpl) then) =
      __$$UnknownFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object? error, StackTrace? stackTrace});
}

/// @nodoc
class __$$UnknownFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$UnknownFailureImpl>
    implements _$$UnknownFailureImplCopyWith<$Res> {
  __$$UnknownFailureImplCopyWithImpl(
      _$UnknownFailureImpl _value, $Res Function(_$UnknownFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_$UnknownFailureImpl(
      freezed == error ? _value.error : error,
      freezed == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc

class _$UnknownFailureImpl implements UnknownFailure {
  const _$UnknownFailureImpl([this.error, this.stackTrace]);

  @override
  final Object? error;
  @override
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'Failure.unknown(error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownFailureImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(error), stackTrace);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      __$$UnknownFailureImplCopyWithImpl<_$UnknownFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) generic,
    required TResult Function(String message) network,
    required TResult Function(String message) database,
    required TResult Function(String message) auth,
    required TResult Function(String message) validation,
    required TResult Function(String? message) notFound,
    required TResult Function(String message) permissionDenied,
    required TResult Function(String message) cache,
    required TResult Function(String message) sync,
    required TResult Function(Object? error, StackTrace? stackTrace) unknown,
  }) {
    return unknown(error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? generic,
    TResult? Function(String message)? network,
    TResult? Function(String message)? database,
    TResult? Function(String message)? auth,
    TResult? Function(String message)? validation,
    TResult? Function(String? message)? notFound,
    TResult? Function(String message)? permissionDenied,
    TResult? Function(String message)? cache,
    TResult? Function(String message)? sync,
    TResult? Function(Object? error, StackTrace? stackTrace)? unknown,
  }) {
    return unknown?.call(error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? generic,
    TResult Function(String message)? network,
    TResult Function(String message)? database,
    TResult Function(String message)? auth,
    TResult Function(String message)? validation,
    TResult Function(String? message)? notFound,
    TResult Function(String message)? permissionDenied,
    TResult Function(String message)? cache,
    TResult Function(String message)? sync,
    TResult Function(Object? error, StackTrace? stackTrace)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(error, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenericFailure value) generic,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(DatabaseFailure value) database,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(PermissionDeniedFailure value) permissionDenied,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(SyncFailure value) sync,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenericFailure value)? generic,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(DatabaseFailure value)? database,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(PermissionDeniedFailure value)? permissionDenied,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(SyncFailure value)? sync,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenericFailure value)? generic,
    TResult Function(NetworkFailure value)? network,
    TResult Function(DatabaseFailure value)? database,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(PermissionDeniedFailure value)? permissionDenied,
    TResult Function(CacheFailure value)? cache,
    TResult Function(SyncFailure value)? sync,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class UnknownFailure implements Failure {
  const factory UnknownFailure(
      [final Object? error,
      final StackTrace? stackTrace]) = _$UnknownFailureImpl;

  Object? get error;
  StackTrace? get stackTrace;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
