import 'package:flutter/material.dart';

/// Enum defining the type of task list to display
enum TaskListType {
  today,
  all,
  completed,
}

/// Configuration class for task list type-specific behavior
class TaskListConfig {
  const TaskListConfig({
    required this.emptyIcon,
    required this.emptyTitle,
    required this.emptySubtitle,
    this.showCompletedIndicator = false,
  });

  /// Icon to display in empty state
  final IconData emptyIcon;

  /// Title to display in empty state
  final String emptyTitle;

  /// Subtitle to display in empty state
  final String emptySubtitle;

  /// Whether to show the "Completed" indicator in task subtitle
  final bool showCompletedIndicator;

  /// Get configuration for a specific task list type
  static TaskListConfig forType(TaskListType type) {
    switch (type) {
      case TaskListType.today:
        return const TaskListConfig(
          emptyIcon: Icons.wb_sunny_outlined,
          emptyTitle: 'No sevas today',
          emptySubtitle: 'Enjoy your day or add a new seva',
          showCompletedIndicator: false,
        );
      case TaskListType.all:
        return const TaskListConfig(
          emptyIcon: Icons.list,
          emptyTitle: 'No sevas yet',
          emptySubtitle: 'Create your first seva to get started',
          showCompletedIndicator: false,
        );
      case TaskListType.completed:
        return const TaskListConfig(
          emptyIcon: Icons.check_circle,
          emptyTitle: 'No completed sevas',
          emptySubtitle: 'Complete sevas will appear here',
          showCompletedIndicator: true,
        );
    }
  }
}
