import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/task.dart';
import '../../models/custom_category.dart';
import '../../services/notification_service.dart';
import '../../services/category_storage_service.dart';
import '../../data/mappers/task_model_mapper.dart';
import '../../domain/entities/task/todo_task.dart';
import '../../domain/entities/task/task_status.dart' as domain_status;
import '../../domain/entities/task/task_priority.dart';
import '../../domain/entities/seva/seva_category.dart';
import '../task_detail_screen.dart';
import '../../presentation/providers/task_providers.dart';
import '../../presentation/providers/task_filter_provider.dart';
import '../../presentation/widgets/common/category_icon_widget.dart';
import '../../presentation/widgets/task/task_search_bar.dart';
import '../../presentation/widgets/task/task_filter_chips.dart';
import '../../presentation/widgets/task/task_filter_dialog.dart' show showTaskFilterDialog;
import '../../presentation/widgets/task/priority_indicator.dart';

/// Completed Tasks tab screen - shows only completed tasks
class CompletedTasksTabScreen extends ConsumerStatefulWidget {
  const CompletedTasksTabScreen({super.key});

  @override
  ConsumerState<CompletedTasksTabScreen> createState() => _CompletedTasksTabScreenState();
}

class _CompletedTasksTabScreenState extends ConsumerState<CompletedTasksTabScreen> {
  Map<String, CustomCategory> _customCategoriesMap = {};

  @override
  void initState() {
    super.initState();
    _loadCustomCategories();
  }

  Future<void> _loadCustomCategories() async {
    final categories = await CategoryStorageService.getAllCategories();
    if (mounted) {
      setState(() {
        _customCategoriesMap = {for (var cat in categories) cat.id: cat};
      });
    }
  }

  void _navigateToNewTask() {
    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: '',
      description: '',
      createdAt: DateTime.now(),
      dueDate: DateTime.now(),
      category: TaskCategory.transportation,
      status: TaskStatus.assigned,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailScreen(
          task: newTask,
          onEditTask: _addTask,
          onDeleteTask: _deleteTask,
          onToggleCompletion: _toggleTaskStatus,
          isNewTask: true,
        ),
      ),
    );
  }

  void _addTask(String taskId, String title) async {
    final newTodoTask = TaskModelMapper.toTodoTask(Task(
      id: taskId,
      title: title,
      description: '',
      createdAt: DateTime.now(),
      dueDate: DateTime.now(),
      category: TaskCategory.transportation,
      status: TaskStatus.assigned,
    ));

    final repository = ref.read(taskRepositoryProvider);
    final result = await repository.createTask(newTodoTask);

    result.fold(
      (failure) => _showErrorSnackBar('Failed to create seva: ${failure.toString()}'),
      (createdTask) {
        final legacyTask = TaskModelMapper.fromTodoTask(createdTask);
        if (legacyTask.dueDate != null) {
          NotificationService.scheduleTaskNotifications(legacyTask);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${createdTask.title} created')),
        );
      },
    );
  }

  void _editTask(Task task) async {
    final repository = ref.read(taskRepositoryProvider);
    final todoTask = TaskModelMapper.toTodoTask(task);

    final result = await repository.updateTask(todoTask);

    result.fold(
      (failure) => _showErrorSnackBar('Failed to update seva: ${failure.toString()}'),
      (updatedTask) {
        final legacyTask = TaskModelMapper.fromTodoTask(updatedTask);
        if (legacyTask.dueDate != null) {
          NotificationService.scheduleTaskNotifications(legacyTask);
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${updatedTask.title} updated')),
          );
        }
      },
    );
  }

  void _editTaskFromCallback(Task task, String newTitle) async {
    final updatedTask = Task(
      id: task.id,
      title: newTitle,
      description: task.description,
      status: task.status,
      createdAt: task.createdAt,
      dueDate: task.dueDate,
      category: task.category,
      customCategoryId: task.customCategoryId,
    );
    _editTask(updatedTask);
  }

  void _deleteTask(String taskId) async {
    final repository = ref.read(taskRepositoryProvider);
    final result = await repository.deleteTask(taskId);

    result.fold(
      (failure) => _showErrorSnackBar('Failed to delete seva: ${failure.toString()}'),
      (_) async {
        // Get the task to cancel its notifications
        final taskResult = await repository.getTaskById(taskId);
        await taskResult.fold(
          (failure) async {},
          (task) async {
            final legacyTask = TaskModelMapper.fromTodoTask(task);
            await NotificationService.cancelTaskNotifications(legacyTask);
          },
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Seva deleted'),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  }

  void _toggleTaskStatus(String taskId) async {
    final repository = ref.read(taskRepositoryProvider);
    final currentTask = await repository.getTaskById(taskId);

    await currentTask.fold(
      (failure) async {
        _showErrorSnackBar('Failed to get seva: ${failure.toString()}');
      },
      (task) async {
        domain_status.TaskStatus newStatus;
        switch (task.status) {
          case domain_status.TaskStatus.pending:
            newStatus = domain_status.TaskStatus.inProgress;
            break;
          case domain_status.TaskStatus.inProgress:
            newStatus = domain_status.TaskStatus.completed;
            break;
          case domain_status.TaskStatus.completed:
            newStatus = domain_status.TaskStatus.pending;
            break;
          default:
            newStatus = domain_status.TaskStatus.pending;
        }

        final updatedTask = task.copyWith(status: newStatus, completedAt: newStatus == domain_status.TaskStatus.completed ? DateTime.now() : null);
        final result = await repository.updateTask(updatedTask);

        result.fold(
          (failure) => _showErrorSnackBar('Failed to update seva: ${failure.toString()}'),
          (_) async {
            if (newStatus == domain_status.TaskStatus.completed) {
              // Cancel notifications for the completed task
              final taskResult = await repository.getTaskById(taskId);
              await taskResult.fold(
                (failure) async {},
                (task) async {
                  final legacyTask = TaskModelMapper.fromTodoTask(task);
                  await NotificationService.cancelTaskNotifications(legacyTask);
                },
              );
            }
          },
        );
      },
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  IconData _getCategoryIcon(TaskCategory category) {
    switch (category) {
      case TaskCategory.transportation:
        return Icons.directions_car;
      case TaskCategory.food:
        return Icons.restaurant;
      case TaskCategory.bills:
        return Icons.receipt_long;
      case TaskCategory.bigExpenditure:
        return Icons.attach_money;
      case TaskCategory.medicines:
        return Icons.medical_services;
      case TaskCategory.centerSeva:
        return Icons.home_repair_service;
    }
  }

  IconData _getStatusIcon(TaskStatus status) {
    switch (status) {
      case TaskStatus.assigned:
        return Icons.assignment;
      case TaskStatus.started:
        return Icons.play_circle_outline;
      case TaskStatus.completed:
        return Icons.check_circle;
    }
  }

  Color _getStatusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.assigned:
        return Colors.grey;
      case TaskStatus.started:
        return Colors.blue;
      case TaskStatus.completed:
        return Colors.green;
    }
  }

  /// Maps legacy TaskCategory to BuiltInCategory value for SevaCategory lookup
  String? _mapTaskCategoryToId(TaskCategory category) {
    switch (category) {
      case TaskCategory.transportation:
        return BuiltInCategory.transportation.value;
      case TaskCategory.food:
        return BuiltInCategory.food.value;
      case TaskCategory.bills:
        return BuiltInCategory.bills.value;
      case TaskCategory.bigExpenditure:
        return BuiltInCategory.bigExpenditure.value;
      case TaskCategory.medicines:
        return BuiltInCategory.medicines.value;
      case TaskCategory.centerSeva:
        return BuiltInCategory.centerSeva.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(completedTasksProvider);
    final filterState = ref.watch(taskFilterStateProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToNewTask,
        tooltip: 'Add Seva',
        backgroundColor: const Color(0xFF8B0000),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Header with "Completed" title
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: const Color(0xFF8B0000),
                  size: 28,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Completed',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B0000),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Search bar
          TaskSearchBar(
            onFilterTap: () => showTaskFilterDialog(context),
          ),

          // Active filter chips
          const TaskFilterChips(),

          const Divider(height: 1),

          // Task list
          Expanded(
            child: tasksAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading sevas: $error',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              data: (todoTasks) {
                // Apply filter to tasks
                final filteredTasks = filterState.applyTo(todoTasks);
                final taskList = filteredTasks
                    .map((todoTask) => TaskModelMapper.fromTodoTask(todoTask))
                    .toList();

                // Empty state for no matching results
                if (filterState.hasActiveFilters && taskList.isEmpty) {
                  return _buildNoFilterResultsView();
                }

                // Original empty state (when no completed tasks)
                if (!filterState.hasActiveFilters && taskList.isEmpty) {
                  return _buildNoCompletedTasksView();
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: taskList.length,
                  itemBuilder: (context, index) {
                    final task = taskList[index];
                    return Dismissible(
                      key: Key(task.id),
                      background: Container(
                        color: const Color(0xFF8B0000),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 20),
                        child: const Row(
                          children: [
                            Icon(Icons.edit, color: Colors.white),
                            SizedBox(width: 8),
                            Text('Edit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      secondaryBackground: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Delete', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            SizedBox(width: 8),
                            Icon(Icons.delete, color: Colors.white),
                          ],
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskDetailScreen(
                                task: task,
                                onEditTask: (taskId, title) => _editTaskFromCallback(task, title),
                                onDeleteTask: _deleteTask,
                                onToggleCompletion: _toggleTaskStatus,
                              ),
                            ),
                          );
                          return false;
                        } else {
                          return await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Delete Seva'),
                                content: Text('Are you sure you want to delete "${task.title}"?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          _deleteTask(task.id);
                        }
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: ListTile(
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (task.isOverdue && !task.isCompleted)
                                const Icon(Icons.warning, color: Colors.red, size: 20)
                              else
                                PriorityIndicator(priority: task.priority, size: 20),
                              const SizedBox(width: 4),
                              CategoryIconConsumer(
                                categoryId: task.customCategoryId ?? _mapTaskCategoryToId(task.category),
                                customCategoryId: null,
                                size: 20,
                              ),
                            ],
                          ),
                          title: Text(
                            task.title,
                            style: TextStyle(
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: task.isCompleted
                                  ? Colors.grey
                                  : (task.isOverdue ? Colors.red.shade700 : Colors.black),
                              fontWeight: task.isOverdue && !task.isCompleted
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              // Category name
                              Row(
                                children: [
                                  Icon(
                                    Icons.category,
                                    size: 12,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 4),
                                  CategoryNameConsumer(
                                    categoryId: task.customCategoryId ?? _mapTaskCategoryToId(task.category),
                                    customCategoryId: null,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              // Status
                              Row(
                                children: [
                                  Icon(
                                    _getStatusIcon(task.status),
                                    size: 12,
                                    color: _getStatusColor(task.status),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    task.status.name,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _getStatusColor(task.status),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              // Priority (only show if not default)
                              if (task.priority != TaskPriority.p3) ...[
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    Icon(
                                      task.priority.icon,
                                      size: 12,
                                      color: task.priority.color,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      task.priority.label,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: task.priority.color,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              // Due time
                              if (task.dueDate != null) ...[
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.schedule,
                                      size: 12,
                                      color: Color(0xFF8B0000),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      task.dueDateDisplay,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF8B0000),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              // Show completion indicator
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    size: 12,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    'Completed',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TaskDetailScreen(
                                  task: task,
                                  onEditTask: (taskId, title) => _editTaskFromCallback(task, title),
                                  onDeleteTask: _deleteTask,
                                  onToggleCompletion: _toggleTaskStatus,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoFilterResultsView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'No matching tasks',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Try adjusting your filters',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoCompletedTasksView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'No completed sevas',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Complete sevas will appear here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
