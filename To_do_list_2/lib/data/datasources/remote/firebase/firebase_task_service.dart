import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:fpdart/fpdart.dart';
import '../../../../domain/entities/task/todo_task.dart';
import '../../../../domain/entities/task/task_priority.dart';
import '../../../../domain/entities/task/task_status.dart';
import '../../../../domain/core/errors/failures.dart';

/// Firebase Firestore service for Seva operations
/// Handles CRUD operations with Firebase Firestore
class SevaTaskService {
  final FirebaseFirestore? _firestore;
  final firebase_auth.FirebaseAuth? _auth;

  SevaTaskService()
      : _auth = Firebase.apps.isNotEmpty
            ? firebase_auth.FirebaseAuth.instance
            : null,
        _firestore = Firebase.apps.isNotEmpty
            ? FirebaseFirestore.instance
            : null;

  /// Check if Firebase is available
  bool get isFirebaseAvailable => Firebase.apps.isNotEmpty && _firestore != null;

  /// Get the current user ID
  String? get currentUserId {
    if (!isFirebaseAvailable || _auth == null) return null;
    return _auth!.currentUser?.uid;
  }

  /// Get the tasks collection reference for current user
  CollectionReference? _getTasksCollection() {
    final userId = currentUserId;
    if (userId == null || _firestore == null) return null;
    return _firestore!.collection('users').doc(userId).collection('tasks');
  }

  /// Create a new task in Firestore
  Future<Either<Failure, TodoTask>> createTask(TodoTask task) async {
    if (!isFirebaseAvailable) {
      return Left(Failure.auth('Firebase is not initialized. Please configure Firebase.'));
    }

    try {
      final userId = currentUserId;
      if (userId == null) {
        return Left(Failure.auth('No user logged in'));
      }

      final tasksCollection = _getTasksCollection();
      if (tasksCollection == null) {
        return Left(Failure.database('Tasks collection not available'));
      }

      final taskRef = tasksCollection.doc(task.id);

      // Convert task to JSON
      final taskData = _taskToJson(task);

      // Set the document
      await taskRef.set(taskData);

      // Return the created task
      return Right(task);
    } on FirebaseException catch (e) {
      return Left(Failure.database('Firebase error: ${e.message}'));
    } catch (e, st) {
      return Left(Failure.unknown(e, st));
    }
  }

  /// Update an existing task in Firestore
  Future<Either<Failure, TodoTask>> updateTask(TodoTask task) async {
    if (!isFirebaseAvailable) {
      return Left(Failure.auth('Firebase is not initialized'));
    }

    try {
      final tasksCollection = _getTasksCollection();
      if (tasksCollection == null) {
        return Left(Failure.database('Tasks collection not available'));
      }

      final taskRef = tasksCollection.doc(task.id);

      // Check if task exists
      final doc = await taskRef.get();
      if (!doc.exists) {
        return Left(Failure.notFound('Task not found'));
      }

      // Update the document
      await taskRef.update(_taskToJson(task));

      return Right(task);
    } on FirebaseException catch (e) {
      return Left(Failure.database('Firebase error: ${e.message}'));
    } catch (e, st) {
      return Left(Failure.unknown(e, st));
    }
  }

  /// Delete a task from Firestore
  Future<Either<Failure, void>> deleteTask(String taskId) async {
    if (!isFirebaseAvailable) {
      return Left(Failure.auth('Firebase is not initialized'));
    }

    try {
      final tasksCollection = _getTasksCollection();
      if (tasksCollection == null) {
        return Left(Failure.database('Tasks collection not available'));
      }

      await tasksCollection.doc(taskId).delete();

      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(Failure.database('Firebase error: ${e.message}'));
    } catch (e, st) {
      return Left(Failure.unknown(e, st));
    }
  }

  /// Watch all tasks for current user as a stream
  Stream<Either<Failure, List<TodoTask>>> watchAllTasks() {
    if (!isFirebaseAvailable) {
      return Stream.value(const Right([]));
    }

    try {
      final tasksCollection = _getTasksCollection();
      if (tasksCollection == null) {
        return Stream.value(const Right([]));
      }

      return tasksCollection
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
            try {
              final tasks = snapshot.docs.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return _taskFromJson(doc.id, data);
              }).toList();
              return Right(tasks);
            } catch (e, st) {
              return Left(Failure.unknown(e, st));
            }
          });
    } catch (e, st) {
      return Stream.value(Left(Failure.unknown(e, st)));
    }
  }

  /// Convert TodoTask to JSON for Firestore
  Map<String, dynamic> _taskToJson(TodoTask task) {
    return {
      'id': task.id,
      'title': task.title,
      'notes': task.notes,
      'priority': task.priority.value,
      'status': task.status.name,
      'dueDate': task.dueDate?.toIso8601String(),
      'dueTime': task.dueTime?.toIso8601String(),
      'categoryId': task.categoryId,
      'customCategoryId': task.customCategoryId,
      'tags': task.tags,
      'estimatedMinutes': task.estimatedMinutes,
      'completedAt': task.completedAt?.toIso8601String(),
      'createdAt': task.createdAt.toIso8601String(),
      'updatedAt': task.updatedAt.toIso8601String(),
      'order': task.order,
      'parentId': task.parentId,
    };
  }

  /// Convert Firestore JSON to TodoTask
  TodoTask _taskFromJson(String id, Map<String, dynamic> json) {
    return TodoTask(
      id: id,
      title: json['title'] as String,
      notes: json['notes'] as String?,
      priority: TaskPriority.values.firstWhere(
        (p) => p.value == json['priority'],
        orElse: () => TaskPriority.p3,
      ),
      status: _parseStatus(json['status'] as String?),
      dueDate: json['dueDate'] != null
          ? DateTime.parse(json['dueDate'] as String)
          : null,
      dueTime: json['dueTime'] != null
          ? DateTime.parse(json['dueTime'] as String)
          : null,
      categoryId: json['categoryId'] as String?,
      customCategoryId: json['customCategoryId'] as String?,
      tags: json['tags'] != null
          ? List<String>.from(json['tags'] as List)
          : [],
      estimatedMinutes: json['estimatedMinutes'] as int?,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      order: json['order'] as int? ?? 0,
      parentId: json['parentId'] as String?,
    );
  }

  /// Parse status string to TaskStatus enum
  TaskStatus _parseStatus(String? statusString) {
    if (statusString == null) return TaskStatus.pending;

    // Try direct enum match first
    try {
      return TaskStatus.values.firstWhere(
        (s) => s.name == statusString,
        orElse: () => TaskStatus.pending,
      );
    } catch (_) {
      // Fallback to legacy string matching
      return TaskStatus.fromLegacyString(statusString);
    }
  }
  Future<Either<Failure, TodoTask>> getTaskById(String taskId) async {
    if (!isFirebaseAvailable) {
      return Left(Failure.auth('Firebase is not initialized'));
    }

    try {
      final tasksCollection = _getTasksCollection();
      if (tasksCollection == null) {
        return Left(Failure.database('Tasks collection not available'));
      }

      final doc = await tasksCollection.doc(taskId).get();
      if (!doc.exists) {
        return Left(Failure.notFound('Task not found'));
      }

      final task = _taskFromJson(doc.id, doc.data() as Map<String, dynamic>);
      return Right(task);
    } on FirebaseException catch (e) {
      return Left(Failure.database('Firebase error: ${e.message}'));
    } catch (e, st) {
      return Left(Failure.unknown(e, st));
    }
  }

  /// Watch tasks by status
  Stream<List<TodoTask>> watchTasksByStatus(TaskStatus status) {
    if (!isFirebaseAvailable) {
      return Stream.value([]);
    }

    try {
      final tasksCollection = _getTasksCollection();
      if (tasksCollection == null) {
        return Stream.value([]);
      }

      return tasksCollection
          .where('status', isEqualTo: status.name)
          .snapshots()
          .map((snapshot) {
            final tasks = snapshot.docs.map((doc) {
              return _taskFromJson(doc.id, doc.data() as Map<String, dynamic>);
            }).toList();
            // Sort client-side to avoid Firestore composite index requirement
            tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            return tasks;
          });
    } catch (e) {
      return Stream.value([]);
    }
  }

  /// Watch tasks by category
  Stream<List<TodoTask>> watchTasksByCategory(String categoryId) {
    if (!isFirebaseAvailable) {
      return Stream.value([]);
    }

    try {
      final tasksCollection = _getTasksCollection();
      if (tasksCollection == null) {
        return Stream.value([]);
      }

      return tasksCollection
          .where('categoryId', isEqualTo: categoryId)
          .snapshots()
          .map((snapshot) {
            final tasks = snapshot.docs.map((doc) {
              return _taskFromJson(doc.id, doc.data() as Map<String, dynamic>);
            }).toList();
            // Sort client-side to avoid Firestore composite index requirement
            tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            return tasks;
          });
    } catch (e) {
      return Stream.value([]);
    }
  }

  /// Watch tasks by custom category
  Stream<List<TodoTask>> watchTasksByCustomCategory(String customCategoryId) {
    if (!isFirebaseAvailable) {
      return Stream.value([]);
    }

    try {
      final tasksCollection = _getTasksCollection();
      if (tasksCollection == null) {
        return Stream.value([]);
      }

      return tasksCollection
          .where('customCategoryId', isEqualTo: customCategoryId)
          .snapshots()
          .map((snapshot) {
            final tasks = snapshot.docs.map((doc) {
              return _taskFromJson(doc.id, doc.data() as Map<String, dynamic>);
            }).toList();
            // Sort client-side to avoid Firestore composite index requirement
            tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            return tasks;
          });
    } catch (e) {
      return Stream.value([]);
    }
  }

  /// Watch pending tasks
  Stream<List<TodoTask>> watchPendingTasks() {
    return watchTasksByStatus(TaskStatus.pending);
  }

  /// Watch completed tasks
  Stream<List<TodoTask>> watchCompletedTasks() {
    return watchTasksByStatus(TaskStatus.completed);
  }

  /// Watch overdue tasks
  Stream<List<TodoTask>> watchOverdueTasks() {
    if (!isFirebaseAvailable) {
      return Stream.value([]);
    }

    try {
      final now = DateTime.now();
      final tasksCollection = _getTasksCollection();
      if (tasksCollection == null) {
        return Stream.value([]);
      }

      return tasksCollection
          .where('status', whereIn: [TaskStatus.pending.name, TaskStatus.inProgress.name])
          .snapshots()
          .map((snapshot) {
            return snapshot.docs
                .map((doc) => _taskFromJson(doc.id, doc.data() as Map<String, dynamic>))
                .where((task) => task.dueDate != null && task.dueDate!.isBefore(now))
                .toList();
          });
    } catch (e) {
      return Stream.value([]);
    }
  }

  /// Watch tasks due today
  Stream<List<TodoTask>> watchTasksDueToday() {
    if (!isFirebaseAvailable) {
      return Stream.value([]);
    }

    try {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final tasksCollection = _getTasksCollection();
      if (tasksCollection == null) {
        return Stream.value([]);
      }

      return tasksCollection
          .where('dueDate', isGreaterThanOrEqualTo: startOfDay.toIso8601String())
          .where('dueDate', isLessThan: endOfDay.toIso8601String())
          .snapshots()
          .map((snapshot) {
            final tasks = snapshot.docs.map((doc) {
              return _taskFromJson(doc.id, doc.data() as Map<String, dynamic>);
            }).toList();
            // Sort client-side by dueDate to avoid Firestore composite index requirement
            tasks.sort((a, b) => (a.dueDate ?? DateTime(2099)).compareTo(b.dueDate ?? DateTime(2099)));
            return tasks;
          });
    } catch (e) {
      return Stream.value([]);
    }
  }

  /// Watch tasks for a specific date
  Stream<List<TodoTask>> watchTasksForDate(DateTime date) {
    if (!isFirebaseAvailable) {
      return Stream.value([]);
    }

    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final tasksCollection = _getTasksCollection();
      if (tasksCollection == null) {
        return Stream.value([]);
      }

      return tasksCollection
          .where('dueDate', isGreaterThanOrEqualTo: startOfDay.toIso8601String())
          .where('dueDate', isLessThan: endOfDay.toIso8601String())
          .snapshots()
          .map((snapshot) {
            final tasks = snapshot.docs.map((doc) {
              return _taskFromJson(doc.id, doc.data() as Map<String, dynamic>);
            }).toList();
            // Sort client-side by dueDate to avoid Firestore composite index requirement
            tasks.sort((a, b) => (a.dueDate ?? DateTime(2099)).compareTo(b.dueDate ?? DateTime(2099)));
            return tasks;
          });
    } catch (e) {
      return Stream.value([]);
    }
  }

  /// Watch tasks for a specific month
  Stream<List<TodoTask>> watchTasksForMonth(DateTime month) {
    if (!isFirebaseAvailable) {
      return Stream.value([]);
    }

    try {
      final startOfMonth = DateTime(month.year, month.month, 1);
      final endOfMonth = month.month == 12
          ? DateTime(month.year + 1, 1, 1)
          : DateTime(month.year, month.month + 1, 1);

      final tasksCollection = _getTasksCollection();
      if (tasksCollection == null) {
        return Stream.value([]);
      }

      return tasksCollection
          .where('dueDate', isGreaterThanOrEqualTo: startOfMonth.toIso8601String())
          .where('dueDate', isLessThan: endOfMonth.toIso8601String())
          .snapshots()
          .map((snapshot) {
            final tasks = snapshot.docs.map((doc) {
              return _taskFromJson(doc.id, doc.data() as Map<String, dynamic>);
            }).toList();
            // Sort client-side by dueDate to avoid Firestore composite index requirement
            tasks.sort((a, b) => (a.dueDate ?? DateTime(2099)).compareTo(b.dueDate ?? DateTime(2099)));
            return tasks;
          });
    } catch (e) {
      return Stream.value([]);
    }
  }

  /// Watch subtasks
  Stream<List<TodoTask>> watchSubtasks(String parentId) {
    if (!isFirebaseAvailable) {
      return Stream.value([]);
    }

    try {
      final tasksCollection = _getTasksCollection();
      if (tasksCollection == null) {
        return Stream.value([]);
      }

      return tasksCollection
          .where('parentId', isEqualTo: parentId)
          .snapshots()
          .map((snapshot) {
            final tasks = snapshot.docs.map((doc) {
              return _taskFromJson(doc.id, doc.data() as Map<String, dynamic>);
            }).toList();
            // Sort client-side to avoid Firestore composite index requirement
            tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            return tasks;
          });
    } catch (e) {
      return Stream.value([]);
    }
  }

  /// Search tasks
  Stream<List<TodoTask>> searchTasks(String query) {
    if (!isFirebaseAvailable) {
      return Stream.value([]);
    }

    try {
      final tasksCollection = _getTasksCollection();
      if (tasksCollection == null) {
        return Stream.value([]);
      }

      return tasksCollection
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
            final tasks = snapshot.docs.map((doc) {
              return _taskFromJson(doc.id, doc.data() as Map<String, dynamic>);
            }).toList();

            return tasks.where((task) =>
              task.title.toLowerCase().contains(query.toLowerCase()) ||
              (task.notes?.toLowerCase().contains(query.toLowerCase()) ?? false)
            ).toList();
          });
    } catch (e) {
      return Stream.value([]);
    }
}
}
