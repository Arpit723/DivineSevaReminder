import 'package:fpdart/fpdart.dart';
import '../../domain/entities/task/todo_task.dart';
import '../../domain/entities/task/task_status.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/core/errors/failures.dart';
import '../datasources/remote/firebase/firebase_task_service.dart';

/// Firebase-only implementation of TaskRepository
/// Uses Firebase Firestore as the single source of truth
/// Firebase SDK handles offline caching automatically
class FirebaseTaskRepository implements TaskRepository {
  final SevaTaskService _firebaseService;

  FirebaseTaskRepository(this._firebaseService);

  @override
  Stream<List<TodoTask>> watchAllTasks() {
    return _firebaseService.watchAllTasks().map(
      (result) => result.fold(
        (failure) => <TodoTask>[],
        (tasks) => tasks,
      ),
    );
  }

  @override
  Future<Either<Failure, List<TodoTask>>> getAllTasks() async {
    try {
      final result = await _firebaseService.watchAllTasks().first;
      return result.fold(
        (failure) => Left(failure),
        (tasks) => Right(tasks),
      );
    } catch (e, st) {
      return Left(Failure.unknown(e, st));
    }
  }

  @override
  Stream<Either<Failure, TodoTask>> watchTaskById(String id) {
    return _firebaseService.watchAllTasks().map(
      (result) => result.fold(
        (failure) => Left(failure),
        (tasks) {
          final task = tasks.where((t) => t.id == id).firstOrNull;
          if (task == null) {
            return Left(Failure.notFound('Task not found'));
          }
          return Right(task);
        },
      ),
    );
  }

  @override
  Future<Either<Failure, TodoTask>> getTaskById(String id) async {
    return _firebaseService.getTaskById(id);
  }

  @override
  Stream<List<TodoTask>> watchTasksByStatus(TaskStatus status) {
    return _firebaseService.watchTasksByStatus(status);
  }

  @override
  Stream<List<TodoTask>> watchTasksByCategory(String categoryId) {
    return _firebaseService.watchTasksByCategory(categoryId);
  }

  @override
  Stream<List<TodoTask>> watchTasksByCustomCategory(String customCategoryId) {
    return _firebaseService.watchTasksByCustomCategory(customCategoryId);
  }

  @override
  Stream<List<TodoTask>> watchPendingTasks() {
    return _firebaseService.watchPendingTasks();
  }

  @override
  Stream<List<TodoTask>> watchCompletedTasks() {
    return _firebaseService.watchCompletedTasks();
  }

  @override
  Stream<List<TodoTask>> watchOverdueTasks() {
    return _firebaseService.watchOverdueTasks();
  }

  @override
  Stream<List<TodoTask>> watchTasksDueToday() {
    return _firebaseService.watchTasksDueToday();
  }

  @override
  Stream<List<TodoTask>> watchTasksForDate(DateTime date) {
    return _firebaseService.watchTasksForDate(date);
  }

  @override
  Stream<List<TodoTask>> watchTasksForMonth(DateTime month) {
    return _firebaseService.watchTasksForMonth(month);
  }

  @override
  Stream<List<TodoTask>> watchSubtasks(String parentId) {
    return _firebaseService.watchSubtasks(parentId);
  }

  @override
  Stream<List<TodoTask>> searchTasks(String query) {
    return _firebaseService.searchTasks(query);
  }

  @override
  Future<Either<Failure, TodoTask>> createTask(TodoTask task) async {
    return _firebaseService.createTask(task);
  }

  @override
  Future<Either<Failure, TodoTask>> updateTask(TodoTask task) async {
    return _firebaseService.updateTask(task);
  }

  @override
  Future<Either<Failure, void>> deleteTask(String id) async {
    return _firebaseService.deleteTask(id);
  }

  @override
  Future<Either<Failure, void>> deleteTasks(List<String> ids) async {
    try {
      for (final id in ids) {
        final result = await _firebaseService.deleteTask(id);
        if (result.isLeft()) {
          return result;
        }
      }
      return const Right(null);
    } catch (e, st) {
      return Left(Failure.unknown(e, st));
    }
  }

  @override
  Future<Either<Failure, TodoTask>> updateTaskStatus(
    String id,
    TaskStatus status,
  ) async {
    final taskResult = await _firebaseService.getTaskById(id);
    return taskResult.fold(
      (failure) => Left(failure),
      (task) {
        final updatedTask = task.copyWith(
          status: status,
          updatedAt: DateTime.now(),
        );
        return _firebaseService.updateTask(updatedTask);
      },
    );
  }

  @override
  Future<Either<Failure, TodoTask>> markTaskCompleted(String id) {
    return updateTaskStatus(id, TaskStatus.completed);
  }

  @override
  Future<Either<Failure, TodoTask>> markTaskInProgress(String id) {
    return updateTaskStatus(id, TaskStatus.inProgress);
  }

  @override
  Future<Either<Failure, TodoTask>> markTaskPending(String id) {
    return updateTaskStatus(id, TaskStatus.pending);
  }

  @override
  Future<Either<Failure, int>> getTaskCountByStatus(TaskStatus status) async {
    try {
      final tasks = await _firebaseService.watchTasksByStatus(status).first;
      return Right(tasks.length);
    } catch (e, st) {
      return Left(Failure.unknown(e, st));
    }
  }

  @override
  Future<Either<Failure, int>> getTotalTaskCount() async {
    try {
      final result = await _firebaseService.watchAllTasks().first;
      return result.fold(
        (failure) => Left(failure),
        (tasks) => Right(tasks.length),
      );
    } catch (e, st) {
      return Left(Failure.unknown(e, st));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCompletedTasks() async {
    try {
      final completedTasks = await _firebaseService.watchCompletedTasks().first;
      for (final task in completedTasks) {
        await _firebaseService.deleteTask(task.id);
      }
      return const Right(null);
    } catch (e, st) {
      return Left(Failure.unknown(e, st));
    }
  }
}
