// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tasksForDateHash() => r'779746f289aca2501e881d22d743b9827c5b848f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider for watching tasks for a specific date
///
/// Copied from [tasksForDate].
@ProviderFor(tasksForDate)
const tasksForDateProvider = TasksForDateFamily();

/// Provider for watching tasks for a specific date
///
/// Copied from [tasksForDate].
class TasksForDateFamily extends Family<AsyncValue<List<TodoTask>>> {
  /// Provider for watching tasks for a specific date
  ///
  /// Copied from [tasksForDate].
  const TasksForDateFamily();

  /// Provider for watching tasks for a specific date
  ///
  /// Copied from [tasksForDate].
  TasksForDateProvider call(
    DateTime date,
  ) {
    return TasksForDateProvider(
      date,
    );
  }

  @override
  TasksForDateProvider getProviderOverride(
    covariant TasksForDateProvider provider,
  ) {
    return call(
      provider.date,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tasksForDateProvider';
}

/// Provider for watching tasks for a specific date
///
/// Copied from [tasksForDate].
class TasksForDateProvider extends AutoDisposeStreamProvider<List<TodoTask>> {
  /// Provider for watching tasks for a specific date
  ///
  /// Copied from [tasksForDate].
  TasksForDateProvider(
    DateTime date,
  ) : this._internal(
          (ref) => tasksForDate(
            ref as TasksForDateRef,
            date,
          ),
          from: tasksForDateProvider,
          name: r'tasksForDateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tasksForDateHash,
          dependencies: TasksForDateFamily._dependencies,
          allTransitiveDependencies:
              TasksForDateFamily._allTransitiveDependencies,
          date: date,
        );

  TasksForDateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime date;

  @override
  Override overrideWith(
    Stream<List<TodoTask>> Function(TasksForDateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TasksForDateProvider._internal(
        (ref) => create(ref as TasksForDateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<TodoTask>> createElement() {
    return _TasksForDateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TasksForDateProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TasksForDateRef on AutoDisposeStreamProviderRef<List<TodoTask>> {
  /// The parameter `date` of this provider.
  DateTime get date;
}

class _TasksForDateProviderElement
    extends AutoDisposeStreamProviderElement<List<TodoTask>>
    with TasksForDateRef {
  _TasksForDateProviderElement(super.provider);

  @override
  DateTime get date => (origin as TasksForDateProvider).date;
}

String _$taskCountByMonthHash() => r'e6424a302bce14a9e26cdf2ac1acc7538bb61117';

/// Provider for getting task count per day for a specific month
/// Returns a Map where key is the date (normalized to midnight) and value is the task count
///
/// Copied from [taskCountByMonth].
@ProviderFor(taskCountByMonth)
const taskCountByMonthProvider = TaskCountByMonthFamily();

/// Provider for getting task count per day for a specific month
/// Returns a Map where key is the date (normalized to midnight) and value is the task count
///
/// Copied from [taskCountByMonth].
class TaskCountByMonthFamily extends Family<AsyncValue<Map<DateTime, int>>> {
  /// Provider for getting task count per day for a specific month
  /// Returns a Map where key is the date (normalized to midnight) and value is the task count
  ///
  /// Copied from [taskCountByMonth].
  const TaskCountByMonthFamily();

  /// Provider for getting task count per day for a specific month
  /// Returns a Map where key is the date (normalized to midnight) and value is the task count
  ///
  /// Copied from [taskCountByMonth].
  TaskCountByMonthProvider call(
    DateTime month,
  ) {
    return TaskCountByMonthProvider(
      month,
    );
  }

  @override
  TaskCountByMonthProvider getProviderOverride(
    covariant TaskCountByMonthProvider provider,
  ) {
    return call(
      provider.month,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'taskCountByMonthProvider';
}

/// Provider for getting task count per day for a specific month
/// Returns a Map where key is the date (normalized to midnight) and value is the task count
///
/// Copied from [taskCountByMonth].
class TaskCountByMonthProvider
    extends AutoDisposeStreamProvider<Map<DateTime, int>> {
  /// Provider for getting task count per day for a specific month
  /// Returns a Map where key is the date (normalized to midnight) and value is the task count
  ///
  /// Copied from [taskCountByMonth].
  TaskCountByMonthProvider(
    DateTime month,
  ) : this._internal(
          (ref) => taskCountByMonth(
            ref as TaskCountByMonthRef,
            month,
          ),
          from: taskCountByMonthProvider,
          name: r'taskCountByMonthProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$taskCountByMonthHash,
          dependencies: TaskCountByMonthFamily._dependencies,
          allTransitiveDependencies:
              TaskCountByMonthFamily._allTransitiveDependencies,
          month: month,
        );

  TaskCountByMonthProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.month,
  }) : super.internal();

  final DateTime month;

  @override
  Override overrideWith(
    Stream<Map<DateTime, int>> Function(TaskCountByMonthRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TaskCountByMonthProvider._internal(
        (ref) => create(ref as TaskCountByMonthRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        month: month,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Map<DateTime, int>> createElement() {
    return _TaskCountByMonthProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskCountByMonthProvider && other.month == month;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TaskCountByMonthRef on AutoDisposeStreamProviderRef<Map<DateTime, int>> {
  /// The parameter `month` of this provider.
  DateTime get month;
}

class _TaskCountByMonthProviderElement
    extends AutoDisposeStreamProviderElement<Map<DateTime, int>>
    with TaskCountByMonthRef {
  _TaskCountByMonthProviderElement(super.provider);

  @override
  DateTime get month => (origin as TaskCountByMonthProvider).month;
}

String _$upcomingTasksGroupedHash() =>
    r'5914186043e8c9ea72141a68f0ac679e34787862';

/// Provider for watching upcoming tasks grouped by date
///
/// Copied from [upcomingTasksGrouped].
@ProviderFor(upcomingTasksGrouped)
final upcomingTasksGroupedProvider =
    AutoDisposeStreamProvider<Map<DateTime, List<TodoTask>>>.internal(
  upcomingTasksGrouped,
  name: r'upcomingTasksGroupedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$upcomingTasksGroupedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UpcomingTasksGroupedRef
    = AutoDisposeStreamProviderRef<Map<DateTime, List<TodoTask>>>;
String _$calendarSelectedDateHash() =>
    r'363ba6aa18797ca26c5caa80462672e93092abf6';

/// Provider for managing the currently selected date in the calendar
///
/// Copied from [CalendarSelectedDate].
@ProviderFor(CalendarSelectedDate)
final calendarSelectedDateProvider =
    AutoDisposeNotifierProvider<CalendarSelectedDate, DateTime>.internal(
  CalendarSelectedDate.new,
  name: r'calendarSelectedDateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$calendarSelectedDateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CalendarSelectedDate = AutoDisposeNotifier<DateTime>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
