import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/task/task_filter.dart';
import '../../domain/entities/task/task_status.dart';
import '../../domain/entities/task/task_priority.dart';

part 'task_filter_provider.g.dart';

/// Provider for managing task filter state
@riverpod
class TaskFilterState extends _$TaskFilterState {
  @override
  TaskFilter build() {
    return const TaskFilter();
  }

  /// Update search query
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  /// Set status filter
  void setStatusFilter(TaskStatus? status) {
    state = state.copyWith(status: () => status);
  }

  /// Set priority filter
  void setPriorityFilter(TaskPriority? priority) {
    state = state.copyWith(priority: () => priority);
  }

  /// Set category filter
  void setCategoryFilter(String? categoryId) {
    state = state.copyWith(categoryId: () => categoryId);
  }

  /// Set custom category filter
  void setCustomCategoryFilter(String? customCategoryId) {
    state = state.copyWith(customCategoryId: () => customCategoryId);
  }

  /// Add tag filter
  void addTagFilter(String tag) {
    final updatedTags = [...state.tags, tag];
    state = state.copyWith(tags: updatedTags);
  }

  /// Remove tag filter
  void removeTagFilter(String tag) {
    final updatedTags = state.tags.where((t) => t != tag).toList();
    state = state.copyWith(tags: updatedTags);
  }

  /// Clear all filters
  void clearFilters() {
    state = const TaskFilter();
  }

  /// Clear specific filter types
  void clearSearch() {
    state = state.copyWith(searchQuery: '');
  }

  void clearStatus() {
    state = state.copyWith(status: () => null);
  }

  void clearPriority() {
    state = state.copyWith(priority: () => null);
  }

  void clearCategory() {
    state = state.copyWith(categoryId: () => null, customCategoryId: () => null);
  }

  void clearTags() {
    state = state.copyWith(tags: []);
  }
}
