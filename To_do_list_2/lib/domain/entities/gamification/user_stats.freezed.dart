// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserStats _$UserStatsFromJson(Map<String, dynamic> json) {
  return _UserStats.fromJson(json);
}

/// @nodoc
mixin _$UserStats {
  String get userId => throw _privateConstructorUsedError;
  int get totalTasksCompleted => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  int get bestStreak => throw _privateConstructorUsedError;
  int get totalSevaMinutes => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  int get xp => throw _privateConstructorUsedError;
  List<String> get achievementIds => throw _privateConstructorUsedError;
  DateTime? get lastActiveDate => throw _privateConstructorUsedError;
  DateTime? get lastCompletedDate => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserStatsCopyWith<UserStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatsCopyWith<$Res> {
  factory $UserStatsCopyWith(UserStats value, $Res Function(UserStats) then) =
      _$UserStatsCopyWithImpl<$Res, UserStats>;
  @useResult
  $Res call(
      {String userId,
      int totalTasksCompleted,
      int currentStreak,
      int bestStreak,
      int totalSevaMinutes,
      int level,
      int xp,
      List<String> achievementIds,
      DateTime? lastActiveDate,
      DateTime? lastCompletedDate,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$UserStatsCopyWithImpl<$Res, $Val extends UserStats>
    implements $UserStatsCopyWith<$Res> {
  _$UserStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? totalTasksCompleted = null,
    Object? currentStreak = null,
    Object? bestStreak = null,
    Object? totalSevaMinutes = null,
    Object? level = null,
    Object? xp = null,
    Object? achievementIds = null,
    Object? lastActiveDate = freezed,
    Object? lastCompletedDate = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      totalTasksCompleted: null == totalTasksCompleted
          ? _value.totalTasksCompleted
          : totalTasksCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      bestStreak: null == bestStreak
          ? _value.bestStreak
          : bestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalSevaMinutes: null == totalSevaMinutes
          ? _value.totalSevaMinutes
          : totalSevaMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      xp: null == xp
          ? _value.xp
          : xp // ignore: cast_nullable_to_non_nullable
              as int,
      achievementIds: null == achievementIds
          ? _value.achievementIds
          : achievementIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastActiveDate: freezed == lastActiveDate
          ? _value.lastActiveDate
          : lastActiveDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastCompletedDate: freezed == lastCompletedDate
          ? _value.lastCompletedDate
          : lastCompletedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserStatsImplCopyWith<$Res>
    implements $UserStatsCopyWith<$Res> {
  factory _$$UserStatsImplCopyWith(
          _$UserStatsImpl value, $Res Function(_$UserStatsImpl) then) =
      __$$UserStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      int totalTasksCompleted,
      int currentStreak,
      int bestStreak,
      int totalSevaMinutes,
      int level,
      int xp,
      List<String> achievementIds,
      DateTime? lastActiveDate,
      DateTime? lastCompletedDate,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$UserStatsImplCopyWithImpl<$Res>
    extends _$UserStatsCopyWithImpl<$Res, _$UserStatsImpl>
    implements _$$UserStatsImplCopyWith<$Res> {
  __$$UserStatsImplCopyWithImpl(
      _$UserStatsImpl _value, $Res Function(_$UserStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? totalTasksCompleted = null,
    Object? currentStreak = null,
    Object? bestStreak = null,
    Object? totalSevaMinutes = null,
    Object? level = null,
    Object? xp = null,
    Object? achievementIds = null,
    Object? lastActiveDate = freezed,
    Object? lastCompletedDate = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$UserStatsImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      totalTasksCompleted: null == totalTasksCompleted
          ? _value.totalTasksCompleted
          : totalTasksCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      bestStreak: null == bestStreak
          ? _value.bestStreak
          : bestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalSevaMinutes: null == totalSevaMinutes
          ? _value.totalSevaMinutes
          : totalSevaMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      xp: null == xp
          ? _value.xp
          : xp // ignore: cast_nullable_to_non_nullable
              as int,
      achievementIds: null == achievementIds
          ? _value._achievementIds
          : achievementIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastActiveDate: freezed == lastActiveDate
          ? _value.lastActiveDate
          : lastActiveDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastCompletedDate: freezed == lastCompletedDate
          ? _value.lastCompletedDate
          : lastCompletedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserStatsImpl extends _UserStats {
  const _$UserStatsImpl(
      {required this.userId,
      this.totalTasksCompleted = 0,
      this.currentStreak = 0,
      this.bestStreak = 0,
      this.totalSevaMinutes = 0,
      this.level = 1,
      this.xp = 0,
      final List<String> achievementIds = const [],
      this.lastActiveDate,
      this.lastCompletedDate,
      required this.createdAt,
      required this.updatedAt})
      : _achievementIds = achievementIds,
        super._();

  factory _$UserStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserStatsImplFromJson(json);

  @override
  final String userId;
  @override
  @JsonKey()
  final int totalTasksCompleted;
  @override
  @JsonKey()
  final int currentStreak;
  @override
  @JsonKey()
  final int bestStreak;
  @override
  @JsonKey()
  final int totalSevaMinutes;
  @override
  @JsonKey()
  final int level;
  @override
  @JsonKey()
  final int xp;
  final List<String> _achievementIds;
  @override
  @JsonKey()
  List<String> get achievementIds {
    if (_achievementIds is EqualUnmodifiableListView) return _achievementIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_achievementIds);
  }

  @override
  final DateTime? lastActiveDate;
  @override
  final DateTime? lastCompletedDate;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'UserStats(userId: $userId, totalTasksCompleted: $totalTasksCompleted, currentStreak: $currentStreak, bestStreak: $bestStreak, totalSevaMinutes: $totalSevaMinutes, level: $level, xp: $xp, achievementIds: $achievementIds, lastActiveDate: $lastActiveDate, lastCompletedDate: $lastCompletedDate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStatsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.totalTasksCompleted, totalTasksCompleted) ||
                other.totalTasksCompleted == totalTasksCompleted) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.bestStreak, bestStreak) ||
                other.bestStreak == bestStreak) &&
            (identical(other.totalSevaMinutes, totalSevaMinutes) ||
                other.totalSevaMinutes == totalSevaMinutes) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.xp, xp) || other.xp == xp) &&
            const DeepCollectionEquality()
                .equals(other._achievementIds, _achievementIds) &&
            (identical(other.lastActiveDate, lastActiveDate) ||
                other.lastActiveDate == lastActiveDate) &&
            (identical(other.lastCompletedDate, lastCompletedDate) ||
                other.lastCompletedDate == lastCompletedDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      totalTasksCompleted,
      currentStreak,
      bestStreak,
      totalSevaMinutes,
      level,
      xp,
      const DeepCollectionEquality().hash(_achievementIds),
      lastActiveDate,
      lastCompletedDate,
      createdAt,
      updatedAt);

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStatsImplCopyWith<_$UserStatsImpl> get copyWith =>
      __$$UserStatsImplCopyWithImpl<_$UserStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserStatsImplToJson(
      this,
    );
  }
}

abstract class _UserStats extends UserStats {
  const factory _UserStats(
      {required final String userId,
      final int totalTasksCompleted,
      final int currentStreak,
      final int bestStreak,
      final int totalSevaMinutes,
      final int level,
      final int xp,
      final List<String> achievementIds,
      final DateTime? lastActiveDate,
      final DateTime? lastCompletedDate,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$UserStatsImpl;
  const _UserStats._() : super._();

  factory _UserStats.fromJson(Map<String, dynamic> json) =
      _$UserStatsImpl.fromJson;

  @override
  String get userId;
  @override
  int get totalTasksCompleted;
  @override
  int get currentStreak;
  @override
  int get bestStreak;
  @override
  int get totalSevaMinutes;
  @override
  int get level;
  @override
  int get xp;
  @override
  List<String> get achievementIds;
  @override
  DateTime? get lastActiveDate;
  @override
  DateTime? get lastCompletedDate;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserStatsImplCopyWith<_$UserStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
