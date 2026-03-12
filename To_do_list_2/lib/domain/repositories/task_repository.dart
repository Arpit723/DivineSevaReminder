import 'package:fpdart/fpdart.dart';
import '../entities/task/todo_task.dart';
import '../entities/task/task_status.dart';
import '../core/errors/failures.dart';

/// Repository interface for Task operations
/// Abstracts the data source from the domain layer
abstract class TaskRepository {
  /// Watch all tasks as a stream
  Stream<List<TodoTask>> watchAllTasks();

  /// Get all tasks once
  Future<Either<Failure, List<TodoTask>>> getAllTasks();

  /// Watch a specific task by ID
  Stream<Either<Failure, TodoTask>> watchTaskById(String id);

  /// Get a specific task by ID
  Future<Either<Failure, TodoTask>> getTaskById(String id);

  /// Watch tasks by status
  Stream<List<TodoTask>> watchTasksByStatus(TaskStatus status);

  /// Watch tasks by category ID
  Stream<List<TodoTask>> watchTasksByCategory(String categoryId);

  /// Watch tasks by custom category ID
  Stream<List<TodoTask>> watchTasksByCustomCategory(String customCategoryId);

  /// Watch pending tasks
  Stream<List<TodoTask>> watchPendingTasks();

  /// Watch completed tasks
  Stream<List<TodoTask>> watchCompletedTasks();

  /// Watch overdue tasks
  Stream<List<TodoTask>> watchOverdueTasks();

  /// Watch tasks due today
  Stream<List<TodoTask>> watchTasksDueToday();

  /// Watch tasks for a specific date
  Stream<List<TodoTask>> watchTasksForDate(DateTime date);

  /// Watch tasks for a specific month
  Stream<List<TodoTask>> watchTasksForMonth(DateTime month);

  /// Watch subtasks of a parent task
  Stream<List<TodoTask>> watchSubtasks(String parentId);

  /// Search tasks by query
  Stream<List<TodoTask>> searchTasks(String query);

  /// Create a new task
  Future<Either<Failure, TodoTask>> createTask(TodoTask task);

  /// Update an existing task
  Future<Either<Failure, TodoTask>> updateTask(TodoTask task);

  /// Delete a task
  Future<Either<Failure, void>> deleteTask(String id);

  /// Delete multiple tasks
  Future<Either<Failure, void>> deleteTasks(List<String> ids);

  /// Update task status
  Future<Either<Failure, TodoTask>> updateTaskStatus(
    String id,
    TaskStatus status,
  );

  /// Mark task as completed
  Future<Either<Failure, TodoTask>> markTaskCompleted(String id);

  /// Mark task as in progress
  Future<Either<Failure, TodoTask>> markTaskInProgress(String id);

  /// Mark task as pending
  Future<Either<Failure, TodoTask>> markTaskPending(String id);

  /// Get task count by status
  Future<Either<Failure, int>> getTaskCountByStatus(TaskStatus status);

  /// Get total task count
  Future<Either<Failure, int>> getTotalTaskCount();

  /// Delete all completed tasks
  Future<Either<Failure, void>> deleteCompletedTasks();
}
