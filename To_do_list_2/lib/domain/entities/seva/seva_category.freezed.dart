// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seva_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SevaCategory _$SevaCategoryFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'builtIn':
      return SevaCategoryBuiltIn.fromJson(json);
    case 'custom':
      return SevaCategoryCustom.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'SevaCategory',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$SevaCategory {
  String get id => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, BuiltInCategory category) builtIn,
    required TResult Function(String id, String name, String iconName,
            int colorValue, DateTime? createdAt)
        custom,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, BuiltInCategory category)? builtIn,
    TResult? Function(String id, String name, String iconName, int colorValue,
            DateTime? createdAt)?
        custom,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, BuiltInCategory category)? builtIn,
    TResult Function(String id, String name, String iconName, int colorValue,
            DateTime? createdAt)?
        custom,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SevaCategoryBuiltIn value) builtIn,
    required TResult Function(SevaCategoryCustom value) custom,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SevaCategoryBuiltIn value)? builtIn,
    TResult? Function(SevaCategoryCustom value)? custom,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SevaCategoryBuiltIn value)? builtIn,
    TResult Function(SevaCategoryCustom value)? custom,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this SevaCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SevaCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SevaCategoryCopyWith<SevaCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SevaCategoryCopyWith<$Res> {
  factory $SevaCategoryCopyWith(
          SevaCategory value, $Res Function(SevaCategory) then) =
      _$SevaCategoryCopyWithImpl<$Res, SevaCategory>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$SevaCategoryCopyWithImpl<$Res, $Val extends SevaCategory>
    implements $SevaCategoryCopyWith<$Res> {
  _$SevaCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SevaCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SevaCategoryBuiltInImplCopyWith<$Res>
    implements $SevaCategoryCopyWith<$Res> {
  factory _$$SevaCategoryBuiltInImplCopyWith(_$SevaCategoryBuiltInImpl value,
          $Res Function(_$SevaCategoryBuiltInImpl) then) =
      __$$SevaCategoryBuiltInImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, BuiltInCategory category});
}

/// @nodoc
class __$$SevaCategoryBuiltInImplCopyWithImpl<$Res>
    extends _$SevaCategoryCopyWithImpl<$Res, _$SevaCategoryBuiltInImpl>
    implements _$$SevaCategoryBuiltInImplCopyWith<$Res> {
  __$$SevaCategoryBuiltInImplCopyWithImpl(_$SevaCategoryBuiltInImpl _value,
      $Res Function(_$SevaCategoryBuiltInImpl) _then)
      : super(_value, _then);

  /// Create a copy of SevaCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
  }) {
    return _then(_$SevaCategoryBuiltInImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as BuiltInCategory,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SevaCategoryBuiltInImpl extends SevaCategoryBuiltIn {
  const _$SevaCategoryBuiltInImpl(
      {required this.id, required this.category, final String? $type})
      : $type = $type ?? 'builtIn',
        super._();

  factory _$SevaCategoryBuiltInImpl.fromJson(Map<String, dynamic> json) =>
      _$$SevaCategoryBuiltInImplFromJson(json);

  @override
  final String id;
  @override
  final BuiltInCategory category;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SevaCategory.builtIn(id: $id, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SevaCategoryBuiltInImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, category);

  /// Create a copy of SevaCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SevaCategoryBuiltInImplCopyWith<_$SevaCategoryBuiltInImpl> get copyWith =>
      __$$SevaCategoryBuiltInImplCopyWithImpl<_$SevaCategoryBuiltInImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, BuiltInCategory category) builtIn,
    required TResult Function(String id, String name, String iconName,
            int colorValue, DateTime? createdAt)
        custom,
  }) {
    return builtIn(id, category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, BuiltInCategory category)? builtIn,
    TResult? Function(String id, String name, String iconName, int colorValue,
            DateTime? createdAt)?
        custom,
  }) {
    return builtIn?.call(id, category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, BuiltInCategory category)? builtIn,
    TResult Function(String id, String name, String iconName, int colorValue,
            DateTime? createdAt)?
        custom,
    required TResult orElse(),
  }) {
    if (builtIn != null) {
      return builtIn(id, category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SevaCategoryBuiltIn value) builtIn,
    required TResult Function(SevaCategoryCustom value) custom,
  }) {
    return builtIn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SevaCategoryBuiltIn value)? builtIn,
    TResult? Function(SevaCategoryCustom value)? custom,
  }) {
    return builtIn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SevaCategoryBuiltIn value)? builtIn,
    TResult Function(SevaCategoryCustom value)? custom,
    required TResult orElse(),
  }) {
    if (builtIn != null) {
      return builtIn(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SevaCategoryBuiltInImplToJson(
      this,
    );
  }
}

abstract class SevaCategoryBuiltIn extends SevaCategory {
  const factory SevaCategoryBuiltIn(
      {required final String id,
      required final BuiltInCategory category}) = _$SevaCategoryBuiltInImpl;
  const SevaCategoryBuiltIn._() : super._();

  factory SevaCategoryBuiltIn.fromJson(Map<String, dynamic> json) =
      _$SevaCategoryBuiltInImpl.fromJson;

  @override
  String get id;
  BuiltInCategory get category;

  /// Create a copy of SevaCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SevaCategoryBuiltInImplCopyWith<_$SevaCategoryBuiltInImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SevaCategoryCustomImplCopyWith<$Res>
    implements $SevaCategoryCopyWith<$Res> {
  factory _$$SevaCategoryCustomImplCopyWith(_$SevaCategoryCustomImpl value,
          $Res Function(_$SevaCategoryCustomImpl) then) =
      __$$SevaCategoryCustomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String iconName,
      int colorValue,
      DateTime? createdAt});
}

/// @nodoc
class __$$SevaCategoryCustomImplCopyWithImpl<$Res>
    extends _$SevaCategoryCopyWithImpl<$Res, _$SevaCategoryCustomImpl>
    implements _$$SevaCategoryCustomImplCopyWith<$Res> {
  __$$SevaCategoryCustomImplCopyWithImpl(_$SevaCategoryCustomImpl _value,
      $Res Function(_$SevaCategoryCustomImpl) _then)
      : super(_value, _then);

  /// Create a copy of SevaCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? iconName = null,
    Object? colorValue = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$SevaCategoryCustomImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      iconName: null == iconName
          ? _value.iconName
          : iconName // ignore: cast_nullable_to_non_nullable
              as String,
      colorValue: null == colorValue
          ? _value.colorValue
          : colorValue // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SevaCategoryCustomImpl extends SevaCategoryCustom {
  const _$SevaCategoryCustomImpl(
      {required this.id,
      required this.name,
      required this.iconName,
      required this.colorValue,
      this.createdAt,
      final String? $type})
      : $type = $type ?? 'custom',
        super._();

  factory _$SevaCategoryCustomImpl.fromJson(Map<String, dynamic> json) =>
      _$$SevaCategoryCustomImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String iconName;
  @override
  final int colorValue;
  @override
  final DateTime? createdAt;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SevaCategory.custom(id: $id, name: $name, iconName: $iconName, colorValue: $colorValue, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SevaCategoryCustomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.iconName, iconName) ||
                other.iconName == iconName) &&
            (identical(other.colorValue, colorValue) ||
                other.colorValue == colorValue) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, iconName, colorValue, createdAt);

  /// Create a copy of SevaCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SevaCategoryCustomImplCopyWith<_$SevaCategoryCustomImpl> get copyWith =>
      __$$SevaCategoryCustomImplCopyWithImpl<_$SevaCategoryCustomImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, BuiltInCategory category) builtIn,
    required TResult Function(String id, String name, String iconName,
            int colorValue, DateTime? createdAt)
        custom,
  }) {
    return custom(id, name, iconName, colorValue, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, BuiltInCategory category)? builtIn,
    TResult? Function(String id, String name, String iconName, int colorValue,
            DateTime? createdAt)?
        custom,
  }) {
    return custom?.call(id, name, iconName, colorValue, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, BuiltInCategory category)? builtIn,
    TResult Function(String id, String name, String iconName, int colorValue,
            DateTime? createdAt)?
        custom,
    required TResult orElse(),
  }) {
    if (custom != null) {
      return custom(id, name, iconName, colorValue, createdAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SevaCategoryBuiltIn value) builtIn,
    required TResult Function(SevaCategoryCustom value) custom,
  }) {
    return custom(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SevaCategoryBuiltIn value)? builtIn,
    TResult? Function(SevaCategoryCustom value)? custom,
  }) {
    return custom?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SevaCategoryBuiltIn value)? builtIn,
    TResult Function(SevaCategoryCustom value)? custom,
    required TResult orElse(),
  }) {
    if (custom != null) {
      return custom(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SevaCategoryCustomImplToJson(
      this,
    );
  }
}

abstract class SevaCategoryCustom extends SevaCategory {
  const factory SevaCategoryCustom(
      {required final String id,
      required final String name,
      required final String iconName,
      required final int colorValue,
      final DateTime? createdAt}) = _$SevaCategoryCustomImpl;
  const SevaCategoryCustom._() : super._();

  factory SevaCategoryCustom.fromJson(Map<String, dynamic> json) =
      _$SevaCategoryCustomImpl.fromJson;

  @override
  String get id;
  String get name;
  String get iconName;
  int get colorValue;
  DateTime? get createdAt;

  /// Create a copy of SevaCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SevaCategoryCustomImplCopyWith<_$SevaCategoryCustomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
