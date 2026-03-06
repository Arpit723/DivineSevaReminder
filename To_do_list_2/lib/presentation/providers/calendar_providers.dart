import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/task/todo_task.dart';
import '../../domain/repositories/task_repository.dart';
import 'task_providers.dart';

part 'calendar_providers.g.dart';

/// Provider for managing the currently selected date in the calendar
@riverpod
class CalendarSelectedDate extends _$CalendarSelectedDate {
  @override
  DateTime build() {
    // Return today's date at midnight for consistent comparison
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// Select a specific date
  void selectDate(DateTime date) {
    // Normalize to midnight for consistent comparisons
    state = DateTime(date.year, date.month, date.day);
  }

  /// Navigate to today
  void goToToday() {
    final now = DateTime.now();
    state = DateTime(now.year, now.month, now.day);
  }

  /// Navigate to next month
  void nextMonth() {
    state = DateTime(state.year, state.month + 1, 1);
  }

  /// Navigate to previous month
  void previousMonth() {
    state = DateTime(state.year, state.month - 1, 1);
  }
}

/// Provider for watching tasks for a specific date
@riverpod
Stream<List<TodoTask>> tasksForDate(TasksForDateRef ref, DateTime date) {
  final repository = ref.watch(taskRepositoryProvider);

  // Normalize date to midnight for consistent querying
  final normalizedDate = DateTime(date.year, date.month, date.day);
  return repository.watchTasksForDate(normalizedDate);
}

/// Provider for getting task count per day for a specific month
/// Returns a Map where key is the date (normalized to midnight) and value is the task count
@riverpod
Stream<Map<DateTime, int>> taskCountByMonth(TaskCountByMonthRef ref, DateTime month) {
  final repository = ref.watch(taskRepositoryProvider);

  // Get the start and end of the month
  final startOfMonth = DateTime(month.year, month.month, 1);
  final endOfMonth = DateTime(month.year, month.month + 1, 0, 23, 59, 59);

  return repository.watchTasksForMonth(month).map((tasks) {
    final Map<DateTime, int> taskCounts = {};

    for (final task in tasks) {
      if (task.dueDate == null) continue;

      // Normalize the task's due date to midnight
      final dateKey = DateTime(
        task.dueDate!.year,
        task.dueDate!.month,
        task.dueDate!.day,
      );

      // Only count tasks within the specified month range
      if (dateKey.isAtSameMomentAs(startOfMonth) ||
          (dateKey.isAfter(startOfMonth) && dateKey.isBefore(endOfMonth))) {
        taskCounts[dateKey] = (taskCounts[dateKey] ?? 0) + 1;
      }
    }

    return taskCounts;
  });
}

/// Provider for watching upcoming tasks grouped by date
@riverpod
Stream<Map<DateTime, List<TodoTask>>> upcomingTasksGrouped(UpcomingTasksGroupedRef ref) {
  final repository = ref.watch(taskRepositoryProvider);

  // Get all pending tasks (excluding completed)
  return repository.watchPendingTasks().map((tasks) {
    final Map<DateTime, List<TodoTask>> groupedTasks = {};

    for (final task in tasks) {
      if (task.dueDate == null) continue;

      // Normalize the task's due date to midnight
      final dateKey = DateTime(
        task.dueDate!.year,
        task.dueDate!.month,
        task.dueDate!.day,
      );

      // Add task to the appropriate date group
      if (groupedTasks[dateKey] == null) {
        groupedTasks[dateKey] = [];
      }
      groupedTasks[dateKey]!.add(task);
    }

    // Sort tasks within each date by urgency score and time
    for (final date in groupedTasks.keys) {
      groupedTasks[date]!.sort((a, b) {
        // First sort by completion status
        if (a.isCompleted != b.isCompleted) {
          return a.isCompleted ? 1 : -1;
        }
        // Then by urgency score
        return b.urgencyScore.compareTo(a.urgencyScore);
      });
    }

    return groupedTasks;
  });
}
