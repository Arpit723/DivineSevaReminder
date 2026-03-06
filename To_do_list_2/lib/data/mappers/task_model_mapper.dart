import '../../domain/entities/task/todo_task.dart';
import '../../domain/entities/task/task_priority.dart';
import '../../domain/entities/task/task_status.dart' as domain_status;
import '../../models/task.dart' as legacy_model;

/// Mapper between legacy Task model and new TodoTask entity
/// Used to bridge the old UI (Task) with new Firebase architecture (TodoTask)
class TaskModelMapper {
  /// Convert legacy Task to TodoTask for Firebase storage
  static TodoTask toTodoTask(legacy_model.Task task) {
    // Map old TaskCategory to categoryId
    final categoryId = _mapCategoryToId(task.category);

    // Map old TaskStatus to new TaskStatus
    final status = _mapTaskStatus(task.status);

    return TodoTask(
      id: task.id,
      title: task.title,
      notes: task.description.isNotEmpty ? task.description : null,
      priority: TaskPriority.p3, // Default priority
      status: status,
      dueDate: task.dueDate,
      dueTime: task.dueDate, // Use dueDate as dueTime for legacy tasks
      categoryId: categoryId,
      customCategoryId: task.customCategoryId,
      tags: [], // Empty tags for legacy tasks
      estimatedMinutes: null,
      completedAt: task.status == legacy_model.TaskStatus.completed ? task.dueDate : null,
      createdAt: task.createdAt,
      updatedAt: DateTime.now(), // Use current time as updated
      order: 0, // Default order
      parentId: null, // No parent for legacy tasks
    );
  }

  /// Convert TodoTask back to legacy Task for UI compatibility
  static legacy_model.Task fromTodoTask(TodoTask todoTask) {
    return legacy_model.Task(
      id: todoTask.id,
      title: todoTask.title,
      description: todoTask.notes ?? '',
      status: _mapToLegacyStatus(todoTask.status),
      createdAt: todoTask.createdAt,
      dueDate: todoTask.dueDate ?? todoTask.dueTime,
      category: _mapIdToCategory(todoTask.categoryId, todoTask.customCategoryId),
      customCategoryId: todoTask.customCategoryId,
    );
  }

  /// Convert legacy TaskCategory to categoryId string
  static String _mapCategoryToId(legacy_model.TaskCategory category) {
    switch (category) {
      case legacy_model.TaskCategory.transportation:
        return 'transportation';
      case legacy_model.TaskCategory.food:
        return 'food';
      case legacy_model.TaskCategory.bills:
        return 'bills';
      case legacy_model.TaskCategory.bigExpenditure:
        return 'big_expenditure';
      case legacy_model.TaskCategory.medicines:
        return 'medicines';
      case legacy_model.TaskCategory.centerSeva:
        return 'center_seva';
    }
  }

  /// Convert categoryId back to TaskCategory
  static legacy_model.TaskCategory _mapIdToCategory(String? categoryId, String? customCategoryId) {
    // Use custom category if available
    if (customCategoryId != null) {
      return legacy_model.TaskCategory.centerSeva; // Default for custom categories
    }

    switch (categoryId) {
      case 'transportation':
        return legacy_model.TaskCategory.transportation;
      case 'food':
        return legacy_model.TaskCategory.food;
      case 'bills':
        return legacy_model.TaskCategory.bills;
      case 'big_expenditure':
        return legacy_model.TaskCategory.bigExpenditure;
      case 'medicines':
        return legacy_model.TaskCategory.medicines;
      case 'center_seva':
        return legacy_model.TaskCategory.centerSeva;
      default:
        return legacy_model.TaskCategory.transportation;
    }
  }

  /// Map legacy TaskStatus to new TaskStatus
  static domain_status.TaskStatus _mapTaskStatus(legacy_model.TaskStatus legacyStatus) {
    switch (legacyStatus) {
      case legacy_model.TaskStatus.assigned:
        return domain_status.TaskStatus.pending;
      case legacy_model.TaskStatus.started:
        return domain_status.TaskStatus.inProgress;
      case legacy_model.TaskStatus.completed:
        return domain_status.TaskStatus.completed;
    }
  }

  /// Map new TaskStatus back to legacy TaskStatus
  static legacy_model.TaskStatus _mapToLegacyStatus(domain_status.TaskStatus newStatus) {
    switch (newStatus) {
      case domain_status.TaskStatus.pending:
        return legacy_model.TaskStatus.assigned;
      case domain_status.TaskStatus.inProgress:
        return legacy_model.TaskStatus.started;
      case domain_status.TaskStatus.completed:
        return legacy_model.TaskStatus.completed;
      case domain_status.TaskStatus.archived:
        return legacy_model.TaskStatus.assigned;
    }
  }
}
