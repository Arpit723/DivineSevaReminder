// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sevaTaskServiceHash() => r'd603361aed5f85a19c8f106ee29a023a8026e8c1';

/// Provider for SevaTaskService (Firebase operations)
///
/// Copied from [sevaTaskService].
@ProviderFor(sevaTaskService)
final sevaTaskServiceProvider = AutoDisposeProvider<SevaTaskService>.internal(
  sevaTaskService,
  name: r'sevaTaskServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sevaTaskServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SevaTaskServiceRef = AutoDisposeProviderRef<SevaTaskService>;
String _$taskRepositoryHash() => r'77d58f8192c45ffa27f99d2d8306bef88eff302b';

/// Provider for Firebase-only TaskRepository
///
/// Copied from [taskRepository].
@ProviderFor(taskRepository)
final taskRepositoryProvider = AutoDisposeProvider<TaskRepository>.internal(
  taskRepository,
  name: r'taskRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$taskRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TaskRepositoryRef = AutoDisposeProviderRef<TaskRepository>;
String _$taskListHash() => r'9ea89e3d41f15ea7d032111b5744018bc897c3cc';

/// Provider for watching all tasks
///
/// Copied from [taskList].
@ProviderFor(taskList)
final taskListProvider = AutoDisposeStreamProvider<List<TodoTask>>.internal(
  taskList,
  name: r'taskListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$taskListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TaskListRef = AutoDisposeStreamProviderRef<List<TodoTask>>;
String _$pendingTasksHash() => r'7748966f27d437ecc553f24863152ab35e3c96c0';

/// Provider for watching pending tasks
///
/// Copied from [pendingTasks].
@ProviderFor(pendingTasks)
final pendingTasksProvider = AutoDisposeStreamProvider<List<TodoTask>>.internal(
  pendingTasks,
  name: r'pendingTasksProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$pendingTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PendingTasksRef = AutoDisposeStreamProviderRef<List<TodoTask>>;
String _$completedTasksHash() => r'6c7efc0374c6c55cb17df480e5e6b8ec076a093a';

/// Provider for watching completed tasks
///
/// Copied from [completedTasks].
@ProviderFor(completedTasks)
final completedTasksProvider =
    AutoDisposeStreamProvider<List<TodoTask>>.internal(
  completedTasks,
  name: r'completedTasksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$completedTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CompletedTasksRef = AutoDisposeStreamProviderRef<List<TodoTask>>;
String _$overdueTasksHash() => r'd5df0975f4947e251cd8e452e4f968d573232ca4';

/// Provider for watching overdue tasks
///
/// Copied from [overdueTasks].
@ProviderFor(overdueTasks)
final overdueTasksProvider = AutoDisposeStreamProvider<List<TodoTask>>.internal(
  overdueTasks,
  name: r'overdueTasksProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$overdueTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OverdueTasksRef = AutoDisposeStreamProviderRef<List<TodoTask>>;
String _$tasksDueTodayHash() => r'ff8616051b870b614d2903ac8b9e1ad4392869ed';

/// Provider for watching tasks due today
///
/// Copied from [tasksDueToday].
@ProviderFor(tasksDueToday)
final tasksDueTodayProvider =
    AutoDisposeStreamProvider<List<TodoTask>>.internal(
  tasksDueToday,
  name: r'tasksDueTodayProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tasksDueTodayHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TasksDueTodayRef = AutoDisposeStreamProviderRef<List<TodoTask>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
