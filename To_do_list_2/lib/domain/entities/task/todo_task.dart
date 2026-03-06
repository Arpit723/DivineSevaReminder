import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import 'task_priority.dart';
import 'task_status.dart';
import '../seva/seva_category.dart';

part 'todo_task.freezed.dart';
part 'todo_task.g.dart';

/// Core task entity - the heart of the Divine Seva Reminder application
@freezed
class TodoTask with _$TodoTask, EquatableMixin {
  const TodoTask._();

  const factory TodoTask({
    required String id,
    required String title,
    String? notes,
    @Default(TaskPriority.p3) TaskPriority priority,
    @Default(TaskStatus.pending) TaskStatus status,
    DateTime? dueDate,
    DateTime? dueTime,
    String? categoryId,
    String? customCategoryId,
    @Default([]) List<String> tags,
    int? estimatedMinutes,
    DateTime? completedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0) int order,
    String? parentId, // For subtasks
  }) = _TodoTask;

  factory TodoTask.fromJson(Map<String, dynamic> json) =>
      _$TodoTaskFromJson(json);

  /// Create a new task with defaults
  factory TodoTask.create({
    required String title,
    String? notes,
    TaskPriority priority = TaskPriority.p3,
    DateTime? dueDate,
    DateTime? dueTime,
    String? categoryId,
    List<String> tags = const [],
    int? estimatedMinutes,
    String? parentId,
  }) {
    final now = DateTime.now();
    return TodoTask(
      id: const Uuid().v4(),
      title: title,
      notes: notes,
      priority: priority,
      dueDate: dueDate,
      dueTime: dueTime,
      categoryId: categoryId,
      tags: tags,
      estimatedMinutes: estimatedMinutes,
      parentId: parentId,
      createdAt: now,
      updatedAt: now,
    );
  }

  // MARK: - Computed Properties

  /// Whether the task is overdue
  bool get isOverdue {
    if (dueDate == null || !status.isActive) return false;
    final now = DateTime.now();
    final effectiveDate = effectiveDueDateTime;
    return effectiveDate != null && effectiveDate.isBefore(now);
  }

  /// Whether the task is due today
  bool get isToday {
    if (dueDate == null) return false;
    final now = DateTime.now();
    return dueDate!.year == now.year &&
        dueDate!.month == now.month &&
        dueDate!.day == now.day;
  }

  /// Whether the task is completed
  bool get isCompleted => status.isCompleted;

  /// Whether this is a subtask
  bool get isSubtask => parentId != null;

  /// Combine date and time for precise due datetime
  DateTime? get effectiveDueDateTime {
    if (dueDate == null) return null;
    if (dueTime == null) {
      return DateTime(dueDate!.year, dueDate!.month, dueDate!.day, 23, 59, 59);
    }
    return DateTime(
      dueDate!.year,
      dueDate!.month,
      dueDate!.day,
      dueTime!.hour,
      dueTime!.minute,
    );
  }

  /// Calculate urgency score for smart sorting
  /// Higher score = more urgent
  int get urgencyScore {
    var score = 0;

    // Priority weighting (P1 = 400, P2 = 300, P3 = 200, P4 = 100)
    score += (5 - priority.value) * 100;

    // Overdue bonus
    if (isOverdue) {
      score += 500;
      // Additional points for each day overdue
      final daysOverdue = DateTime.now().difference(dueDate!).inDays;
      score += daysOverdue * 50;
    }

    // Due date proximity bonus
    if (dueDate != null && !isOverdue) {
      final daysUntilDue = dueDate!.difference(DateTime.now()).inDays;
      if (daysUntilDue <= 0) score += 300; // Due today
      else if (daysUntilDue <= 1) score += 200; // Due tomorrow
      else if (daysUntilDue <= 3) score += 100; // Due within 3 days
      else if (daysUntilDue <= 7) score += 50; // Due within a week
    }

    return score;
  }

  /// XP reward for completing this task
  int get xpReward {
    const baseXP = 10;
    final multiplier = priority.xpMultiplier;

    var xp = (baseXP * multiplier).round();

    // Bonus for completing on time or early
    if (dueDate != null && !isOverdue) {
      final daysEarly = dueDate!.difference(DateTime.now()).inDays;
      if (daysEarly > 0) xp += daysEarly * 2;
    }

    // Bonus for estimated time
    if (estimatedMinutes != null) {
      xp += (estimatedMinutes! ~/ 15); // 1 XP per 15 minutes
    }

    return xp;
  }

  /// Format due date for display
  String get dueDateDisplay {
    if (dueDate == null) return 'No due date';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final dueDay = DateTime(dueDate!.year, dueDate!.month, dueDate!.day);

    final timeStr = '${dueDate!.hour}:${dueDate!.minute.toString().padLeft(2, '0')}';

    if (dueDay == today) {
      return 'Today at $timeStr';
    } else if (dueDay == tomorrow) {
      return 'Tomorrow at $timeStr';
    } else {
      return '${dueDate!.day}/${dueDate!.month}/${dueDate!.year} at $timeStr';
    }
  }

  /// Create a copy with completed status
  TodoTask markAsCompleted() {
    return copyWith(
      status: TaskStatus.completed,
      completedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// Create a copy with in-progress status
  TodoTask markAsInProgress() {
    return copyWith(
      status: TaskStatus.inProgress,
      updatedAt: DateTime.now(),
    );
  }

  /// Create a copy with pending status
  TodoTask markAsPending() {
    return copyWith(
      status: TaskStatus.pending,
      updatedAt: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        notes,
        priority,
        status,
        dueDate,
        dueTime,
        categoryId,
        customCategoryId,
        tags,
        estimatedMinutes,
        completedAt,
        createdAt,
        updatedAt,
        order,
        parentId,
      ];
}
