// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TodoTask _$TodoTaskFromJson(Map<String, dynamic> json) {
  return _TodoTask.fromJson(json);
}

/// @nodoc
mixin _$TodoTask {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  TaskPriority get priority => throw _privateConstructorUsedError;
  TaskStatus get status => throw _privateConstructorUsedError;
  DateTime? get dueDate => throw _privateConstructorUsedError;
  DateTime? get dueTime => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;
  String? get customCategoryId => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  int? get estimatedMinutes => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  String? get parentId => throw _privateConstructorUsedError;

  /// Serializes this TodoTask to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TodoTask
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodoTaskCopyWith<TodoTask> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoTaskCopyWith<$Res> {
  factory $TodoTaskCopyWith(TodoTask value, $Res Function(TodoTask) then) =
      _$TodoTaskCopyWithImpl<$Res, TodoTask>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? notes,
      TaskPriority priority,
      TaskStatus status,
      DateTime? dueDate,
      DateTime? dueTime,
      String? categoryId,
      String? customCategoryId,
      List<String> tags,
      int? estimatedMinutes,
      DateTime? completedAt,
      DateTime createdAt,
      DateTime updatedAt,
      int order,
      String? parentId});
}

/// @nodoc
class _$TodoTaskCopyWithImpl<$Res, $Val extends TodoTask>
    implements $TodoTaskCopyWith<$Res> {
  _$TodoTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodoTask
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? notes = freezed,
    Object? priority = null,
    Object? status = null,
    Object? dueDate = freezed,
    Object? dueTime = freezed,
    Object? categoryId = freezed,
    Object? customCategoryId = freezed,
    Object? tags = null,
    Object? estimatedMinutes = freezed,
    Object? completedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? order = null,
    Object? parentId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as TaskPriority,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TaskStatus,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dueTime: freezed == dueTime
          ? _value.dueTime
          : dueTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      customCategoryId: freezed == customCategoryId
          ? _value.customCategoryId
          : customCategoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      estimatedMinutes: freezed == estimatedMinutes
          ? _value.estimatedMinutes
          : estimatedMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodoTaskImplCopyWith<$Res>
    implements $TodoTaskCopyWith<$Res> {
  factory _$$TodoTaskImplCopyWith(
          _$TodoTaskImpl value, $Res Function(_$TodoTaskImpl) then) =
      __$$TodoTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? notes,
      TaskPriority priority,
      TaskStatus status,
      DateTime? dueDate,
      DateTime? dueTime,
      String? categoryId,
      String? customCategoryId,
      List<String> tags,
      int? estimatedMinutes,
      DateTime? completedAt,
      DateTime createdAt,
      DateTime updatedAt,
      int order,
      String? parentId});
}

/// @nodoc
class __$$TodoTaskImplCopyWithImpl<$Res>
    extends _$TodoTaskCopyWithImpl<$Res, _$TodoTaskImpl>
    implements _$$TodoTaskImplCopyWith<$Res> {
  __$$TodoTaskImplCopyWithImpl(
      _$TodoTaskImpl _value, $Res Function(_$TodoTaskImpl) _then)
      : super(_value, _then);

  /// Create a copy of TodoTask
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? notes = freezed,
    Object? priority = null,
    Object? status = null,
    Object? dueDate = freezed,
    Object? dueTime = freezed,
    Object? categoryId = freezed,
    Object? customCategoryId = freezed,
    Object? tags = null,
    Object? estimatedMinutes = freezed,
    Object? completedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? order = null,
    Object? parentId = freezed,
  }) {
    return _then(_$TodoTaskImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as TaskPriority,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TaskStatus,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dueTime: freezed == dueTime
          ? _value.dueTime
          : dueTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      customCategoryId: freezed == customCategoryId
          ? _value.customCategoryId
          : customCategoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      estimatedMinutes: freezed == estimatedMinutes
          ? _value.estimatedMinutes
          : estimatedMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TodoTaskImpl extends _TodoTask {
  const _$TodoTaskImpl(
      {required this.id,
      required this.title,
      this.notes,
      this.priority = TaskPriority.p3,
      this.status = TaskStatus.pending,
      this.dueDate,
      this.dueTime,
      this.categoryId,
      this.customCategoryId,
      final List<String> tags = const [],
      this.estimatedMinutes,
      this.completedAt,
      required this.createdAt,
      required this.updatedAt,
      this.order = 0,
      this.parentId})
      : _tags = tags,
        super._();

  factory _$TodoTaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoTaskImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? notes;
  @override
  @JsonKey()
  final TaskPriority priority;
  @override
  @JsonKey()
  final TaskStatus status;
  @override
  final DateTime? dueDate;
  @override
  final DateTime? dueTime;
  @override
  final String? categoryId;
  @override
  final String? customCategoryId;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final int? estimatedMinutes;
  @override
  final DateTime? completedAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  @JsonKey()
  final int order;
  @override
  final String? parentId;

  /// Create a copy of TodoTask
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoTaskImplCopyWith<_$TodoTaskImpl> get copyWith =>
      __$$TodoTaskImplCopyWithImpl<_$TodoTaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoTaskImplToJson(
      this,
    );
  }
}

abstract class _TodoTask extends TodoTask {
  const factory _TodoTask(
      {required final String id,
      required final String title,
      final String? notes,
      final TaskPriority priority,
      final TaskStatus status,
      final DateTime? dueDate,
      final DateTime? dueTime,
      final String? categoryId,
      final String? customCategoryId,
      final List<String> tags,
      final int? estimatedMinutes,
      final DateTime? completedAt,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final int order,
      final String? parentId}) = _$TodoTaskImpl;
  const _TodoTask._() : super._();

  factory _TodoTask.fromJson(Map<String, dynamic> json) =
      _$TodoTaskImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get notes;
  @override
  TaskPriority get priority;
  @override
  TaskStatus get status;
  @override
  DateTime? get dueDate;
  @override
  DateTime? get dueTime;
  @override
  String? get categoryId;
  @override
  String? get customCategoryId;
  @override
  List<String> get tags;
  @override
  int? get estimatedMinutes;
  @override
  DateTime? get completedAt;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  int get order;
  @override
  String? get parentId;

  /// Create a copy of TodoTask
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodoTaskImplCopyWith<_$TodoTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
