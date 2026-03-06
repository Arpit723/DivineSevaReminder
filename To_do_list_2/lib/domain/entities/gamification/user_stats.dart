import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_stats.freezed.dart';
part 'user_stats.g.dart';

/// User statistics for gamification and progress tracking
@freezed
class UserStats with _$UserStats {
  const UserStats._();

  const factory UserStats({
    required String userId,
    @Default(0) int totalTasksCompleted,
    @Default(0) int currentStreak,
    @Default(0) int bestStreak,
    @Default(0) int totalSevaMinutes,
    @Default(1) int level,
    @Default(0) int xp,
    @Default([]) List<String> achievementIds,
    DateTime? lastActiveDate,
    DateTime? lastCompletedDate,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserStats;

  factory UserStats.fromJson(Map<String, dynamic> json) =>
      _$UserStatsFromJson(json);

  /// Create new user stats
  factory UserStats.create(String userId) {
    final now = DateTime.now();
    return UserStats(
      userId: userId,
      createdAt: now,
      updatedAt: now,
      lastActiveDate: now,
    );
  }

  // MARK: - Computed Properties

  /// XP needed to reach next level
  int get xpForNextLevel => level * 1000;

  /// Remaining XP to reach next level
  int get xpRemaining => xpForNextLevel - (xp % 1000);

  /// Progress to next level (0.0 to 1.0)
  double get levelProgress => (xp % 1000) / 1000;

  /// Current level title
  String get levelTitle {
    if (level <= 5) return 'Seva Beginner';
    if (level <= 10) return 'Dedicated Sevak';
    if (level <= 20) return 'Committed Servant';
    if (level <= 35) return 'Seva Expert';
    if (level <= 50) return 'Selfless Server';
    return 'Divine Servant';
  }

  /// Whether user is on a streak today
  bool get hasStreakToday {
    if (lastCompletedDate == null) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastCompletedDay = DateTime(
      lastCompletedDate!.year,
      lastCompletedDate!.month,
      lastCompletedDate!.day,
    );
    return lastCompletedDay == today;
  }

  /// Get formatted total seva hours
  String get totalSevaHoursDisplay {
    final hours = totalSevaMinutes / 60;
    if (hours >= 1) {
      return '${hours.toStringAsFixed(1)}h';
    }
    return '${totalSevaMinutes}m';
  }

  /// Create copy with XP added
  UserStats addXP(int amount) {
    final newXP = xp + amount;
    final newLevel = 1 + (newXP ~/ 1000);
    return copyWith(
      xp: newXP,
      level: newLevel,
      updatedAt: DateTime.now(),
    );
  }

  /// Create copy with task completed
  UserStats recordTaskCompletion({int? sevaMinutes}) {
    final now = DateTime.now();
    final newStreak = _calculateNewStreak(now);
    final newTotalMinutes = totalSevaMinutes + (sevaMinutes ?? 0);

    return copyWith(
      totalTasksCompleted: totalTasksCompleted + 1,
      currentStreak: newStreak,
      bestStreak: newStreak > bestStreak ? newStreak : bestStreak,
      totalSevaMinutes: newTotalMinutes,
      lastCompletedDate: now,
      lastActiveDate: now,
      updatedAt: now,
    );
  }

  /// Create copy with updated active date
  UserStats updateActiveDate() {
    return copyWith(
      lastActiveDate: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// Create copy with achievement added
  UserStats addAchievement(String achievementId) {
    final updatedAchievements = [...achievementIds, achievementId];
    return copyWith(
      achievementIds: updatedAchievements,
      updatedAt: DateTime.now(),
    );
  }

  /// Calculate new streak based on completion dates
  int _calculateNewStreak(DateTime now) {
    if (lastCompletedDate == null) return 1;

    final today = DateTime(now.year, now.month, now.day);
    final lastCompletedDay = DateTime(
      lastCompletedDate!.year,
      lastCompletedDate!.month,
      lastCompletedDate!.day,
    );

    final difference = today.difference(lastCompletedDay).inDays;

    // If completed today or yesterday, continue streak
    if (difference <= 1) {
      return currentStreak + 1;
    }

    // Streak broken
    return 1;
  }

  /// Reset streak (for when a day is missed)
  UserStats resetStreak() {
    return copyWith(
      currentStreak: 0,
      updatedAt: DateTime.now(),
    );
  }
}
