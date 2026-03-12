import 'package:equatable/equatable.dart';
import 'todo_task.dart';

/// Task filter criteria for searching and filtering tasks
class TaskFilter extends Equatable {
  /// Search query (searches in title and notes)
  final String searchQuery;

  /// Category filter (null = all categories)
  final String? categoryId;

  /// Custom category filter (null = all custom categories)
  final String? customCategoryId;

  /// Tags filter (tasks must have ALL these tags)
  final List<String> tags;

  const TaskFilter({
    this.searchQuery = '',
    this.categoryId,
    this.customCategoryId,
    this.tags = const [],
  });

  /// Check if any filter is active
  bool get hasActiveFilters =>
      searchQuery.isNotEmpty ||
      categoryId != null ||
      customCategoryId != null ||
      tags.isNotEmpty;

  /// Get count of active filters
  int get activeFilterCount {
    var count = 0;
    if (searchQuery.isNotEmpty) count++;
    if (categoryId != null) count++;
    if (customCategoryId != null) count++;
    if (tags.isNotEmpty) count++;
    return count;
  }

  /// Create a copy with modified fields
  TaskFilter copyWith({
    String? searchQuery,
    String? Function()? categoryId,
    String? Function()? customCategoryId,
    List<String>? tags,
  }) {
    return TaskFilter(
      searchQuery: searchQuery ?? this.searchQuery,
      categoryId: categoryId != null ? categoryId() : this.categoryId,
      customCategoryId:
          customCategoryId != null ? customCategoryId() : this.customCategoryId,
      tags: tags ?? this.tags,
    );
  }

  /// Clear all filters
  TaskFilter clear() {
    return const TaskFilter();
  }

  /// Apply filter to a list of tasks
  List<TodoTask> applyTo(List<TodoTask> tasks) {
    return tasks.where((task) {
      // Search query filter
      if (searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        final matchesTitle = task.title.toLowerCase().contains(query);
        final matchesNotes = task.notes?.toLowerCase().contains(query) ?? false;
        if (!matchesTitle && !matchesNotes) return false;
      }

      // Category filter
      if (categoryId != null && task.categoryId != categoryId) return false;

      // Custom category filter
      if (customCategoryId != null && task.customCategoryId != customCategoryId) {
        return false;
      }

      // Tags filter (task must have ALL specified tags)
      if (tags.isNotEmpty) {
        final hasAllTags = tags.every((tag) => task.tags.contains(tag));
        if (!hasAllTags) return false;
      }

      return true;
    }).toList();
  }

  @override
  List<Object?> get props => [
        searchQuery,
        categoryId,
        customCategoryId,
        tags,
      ];
}
