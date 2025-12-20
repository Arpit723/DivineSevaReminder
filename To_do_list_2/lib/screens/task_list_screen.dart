import 'package:flutter/material.dart';
import '../models/task.dart';
import '../models/custom_category.dart';
import '../services/storage_service.dart';
import '../services/notification_service.dart';
import '../services/category_storage_service.dart';
import 'task_detail_screen.dart';
import 'settings_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> tasks = [];
  Map<String, CustomCategory> _customCategoriesMap = {};

  @override
  void initState() {
    super.initState();
    _loadTasks();
    _loadCustomCategories();
    checkNotificationPermissions();
  }

  Future<void> _loadCustomCategories() async {
    final categories = await CategoryStorageService.getAllCategories();
    setState(() {
      _customCategoriesMap = {for (var cat in categories) cat.id: cat};
    });
  }

  void checkNotificationPermissions() async {
    final hasPermission = await NotificationService.checkAndRequestPermissions();
    print("has notifications permission $hasPermission");

    //Show simple notifications
    //await NotificationService.showSimpleTestNotification();

    print("Get pending notifications");
    await NotificationService.getPendingNotifications();
  }
  // Load tasks from storage when app starts
  Future<void> _loadTasks() async {
    final loadedTasks = await StorageService.loadTasks();
    setState(() {
      tasks = loadedTasks;
    });

    // Schedule daily 9 AM reminder for tasks due today
    await NotificationService.scheduleDailyMorningReminder(tasks);
  }

  // Save tasks to storage whenever tasks change
  Future<void> _saveTasks() async {
    await StorageService.saveTasks(tasks);
  }

  void _navigateToNewTask() {
    // Create a temporary task for the new task screen
    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: '',
      description: '',
      createdAt: DateTime.now(),
      dueDate: null,
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
    // Find the existing temporary task to get all its fields
    final tempTaskIndex = tasks.indexWhere((task) => task.id == taskId);
    Task newTask;

    if (tempTaskIndex != -1) {
      // Copy all fields from temporary task
      final tempTask = tasks[tempTaskIndex];
      newTask = Task(
        id: taskId,
        title: title,
        description: tempTask.description,
        createdAt: tempTask.createdAt,
        dueDate: tempTask.dueDate,
        category: tempTask.category,
        status: tempTask.status,
      );
    } else {
      // Create new task with defaults
      newTask = Task(
        id: taskId,
        title: title,
        description: '',
        createdAt: DateTime.now(),
        dueDate: null,
        category: TaskCategory.transportation,
        status: TaskStatus.assigned,
      );
    }

    setState(() {
      // Remove the temporary task if it exists
      tasks.removeWhere((task) => task.id == taskId);
      // Add the new task
      tasks.add(newTask);
    });

    // Schedule notifications if due date is set
    if (newTask.dueDate != null) {
      NotificationService.scheduleTaskNotifications(newTask);
    }

    // Update daily 9 AM reminder with all tasks
    await NotificationService.scheduleDailyMorningReminder(tasks);

    _saveTasks(); // Save after adding task
  }

  void _toggleTaskStatus(String taskId) async {
    setState(() {
      // Find the task with this ID and cycle through statuses
      for (var task in tasks) {
        if (task.id == taskId) {
          switch (task.status) {
            case TaskStatus.assigned:
              task.status = TaskStatus.started;
              break;
            case TaskStatus.started:
              task.status = TaskStatus.completed;
              break;
            case TaskStatus.completed:
              task.status = TaskStatus.assigned;
              break;
          }
          break;
        }
      }
    });

    // Update daily 9 AM reminder (in case task was marked completed)
    await NotificationService.scheduleDailyMorningReminder(tasks);

    _saveTasks(); // Save after status change
  }

  void _editTask(String taskId, String newTitle) async {
    Task? updatedTask;
    setState(() {
      for (var task in tasks) {
        if (task.id == taskId) {
          task.title = newTitle;
          updatedTask = task;
          break;
        }
      }
    });

    // Reschedule notifications if due date is set
    if (updatedTask != null && updatedTask!.dueDate != null) {
      NotificationService.scheduleTaskNotifications(updatedTask!);
    }

    // Update daily 9 AM reminder
    await NotificationService.scheduleDailyMorningReminder(tasks);

    _saveTasks(); // Save after editing task
  }

  void _deleteTask(String taskId) async {
    // Find the task before deleting to cancel its notifications
    final taskToDelete = tasks.firstWhere((task) => task.id == taskId);

    // Cancel notifications for this task
    NotificationService.cancelTaskNotifications(taskToDelete);

    setState(() {
      tasks.removeWhere((task) => task.id == taskId);
    });

    // Update daily 9 AM reminder
    await NotificationService.scheduleDailyMorningReminder(tasks);

    _saveTasks(); // Save after deleting task
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seva List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            tooltip: 'Settings',
          ),
        ],
      ),
      body: tasks.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No services pending!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
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
                // Swipe right to edit
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetailScreen(
                      task: task,
                      onEditTask: _editTask,
                      onDeleteTask: _deleteTask,
                      onToggleCompletion: _toggleTaskStatus,
                    ),
                  ),
                );
                return false; // Don't dismiss
              } else {
                // Swipe left to delete - show confirmation
                return await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete Task'),
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${task.title} deleted'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ListTile(
                leading: task.isOverdue && !task.isCompleted
                    ? const Icon(Icons.warning, color: Colors.red, size: 24)
                    : Icon(
                        task.customCategoryId != null
                            ? Icons.label
                            : _getCategoryIcon(task.category),
                        color: const Color(0xFF8B0000),
                        size: 24,
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
                        Text(
                          task.customCategoryId != null
                              ? (_customCategoriesMap[task.customCategoryId]?.name ?? 'Unknown')
                              : task.category.name,
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
                    // Due date (if exists)
                    if (task.dueDate != null) ...[
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 12,
                            color: task.isOverdue ? Colors.red : const Color(0xFF8B0000),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            task.dueDateDisplay,
                            style: TextStyle(
                              fontSize: 12,
                              color: task.isOverdue ? Colors.red : const Color(0xFF8B0000),
                              fontWeight: task.isOverdue ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskDetailScreen(
                        task: task,
                        onEditTask: _editTask,
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
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 8),
          // Main add task button
          FloatingActionButton(
            onPressed: _navigateToNewTask,
            tooltip: 'Add Task',
            child: const Icon(Icons.add),
          ),
        ],
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
}


