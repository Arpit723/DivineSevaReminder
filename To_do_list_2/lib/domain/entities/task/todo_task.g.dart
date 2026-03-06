// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoTaskImpl _$$TodoTaskImplFromJson(Map<String, dynamic> json) =>
    _$TodoTaskImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      notes: json['notes'] as String?,
      priority: $enumDecodeNullable(_$TaskPriorityEnumMap, json['priority']) ??
          TaskPriority.p3,
      status: $enumDecodeNullable(_$TaskStatusEnumMap, json['status']) ??
          TaskStatus.pending,
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      dueTime: json['dueTime'] == null
          ? null
          : DateTime.parse(json['dueTime'] as String),
      categoryId: json['categoryId'] as String?,
      customCategoryId: json['customCategoryId'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      estimatedMinutes: (json['estimatedMinutes'] as num?)?.toInt(),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      order: (json['order'] as num?)?.toInt() ?? 0,
      parentId: json['parentId'] as String?,
    );

Map<String, dynamic> _$$TodoTaskImplToJson(_$TodoTaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'notes': instance.notes,
      'priority': _$TaskPriorityEnumMap[instance.priority]!,
      'status': _$TaskStatusEnumMap[instance.status]!,
      'dueDate': instance.dueDate?.toIso8601String(),
      'dueTime': instance.dueTime?.toIso8601String(),
      'categoryId': instance.categoryId,
      'customCategoryId': instance.customCategoryId,
      'tags': instance.tags,
      'estimatedMinutes': instance.estimatedMinutes,
      'completedAt': instance.completedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'order': instance.order,
      'parentId': instance.parentId,
    };

const _$TaskPriorityEnumMap = {
  TaskPriority.p1: 1,
  TaskPriority.p2: 2,
  TaskPriority.p3: 3,
  TaskPriority.p4: 4,
};

const _$TaskStatusEnumMap = {
  TaskStatus.pending: 'pending',
  TaskStatus.inProgress: 'inProgress',
  TaskStatus.completed: 'completed',
  TaskStatus.archived: 'archived',
};
