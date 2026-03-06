// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserStatsImpl _$$UserStatsImplFromJson(Map<String, dynamic> json) =>
    _$UserStatsImpl(
      userId: json['userId'] as String,
      totalTasksCompleted: (json['totalTasksCompleted'] as num?)?.toInt() ?? 0,
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      bestStreak: (json['bestStreak'] as num?)?.toInt() ?? 0,
      totalSevaMinutes: (json['totalSevaMinutes'] as num?)?.toInt() ?? 0,
      level: (json['level'] as num?)?.toInt() ?? 1,
      xp: (json['xp'] as num?)?.toInt() ?? 0,
      achievementIds: (json['achievementIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      lastActiveDate: json['lastActiveDate'] == null
          ? null
          : DateTime.parse(json['lastActiveDate'] as String),
      lastCompletedDate: json['lastCompletedDate'] == null
          ? null
          : DateTime.parse(json['lastCompletedDate'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$UserStatsImplToJson(_$UserStatsImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'totalTasksCompleted': instance.totalTasksCompleted,
      'currentStreak': instance.currentStreak,
      'bestStreak': instance.bestStreak,
      'totalSevaMinutes': instance.totalSevaMinutes,
      'level': instance.level,
      'xp': instance.xp,
      'achievementIds': instance.achievementIds,
      'lastActiveDate': instance.lastActiveDate?.toIso8601String(),
      'lastCompletedDate': instance.lastCompletedDate?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
