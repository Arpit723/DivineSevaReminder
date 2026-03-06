import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/datasources/remote/firebase/firebase_task_service.dart';
import '../../data/repositories/firebase_task_repository.dart';
import '../../domain/entities/task/todo_task.dart';
import '../../domain/repositories/task_repository.dart';

part 'task_providers.g.dart';

/// Provider for SevaTaskService (Firebase operations)
@riverpod
SevaTaskService sevaTaskService(SevaTaskServiceRef ref) {
  return SevaTaskService();
}

/// Provider for Firebase-only TaskRepository
@riverpod
TaskRepository taskRepository(TaskRepositoryRef ref) {
  final firebaseService = ref.watch(sevaTaskServiceProvider);
  return FirebaseTaskRepository(firebaseService);
}

/// Provider for watching all tasks
@riverpod
Stream<List<TodoTask>> taskList(TaskListRef ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return repository.watchAllTasks();
}

/// Provider for watching pending tasks
@riverpod
Stream<List<TodoTask>> pendingTasks(PendingTasksRef ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return repository.watchPendingTasks();
}

/// Provider for watching completed tasks
@riverpod
Stream<List<TodoTask>> completedTasks(CompletedTasksRef ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return repository.watchCompletedTasks();
}

/// Provider for watching overdue tasks
@riverpod
Stream<List<TodoTask>> overdueTasks(OverdueTasksRef ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return repository.watchOverdueTasks();
}

/// Provider for watching tasks due today
@riverpod
Stream<List<TodoTask>> tasksDueToday(TasksDueTodayRef ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return repository.watchTasksDueToday();
}
