import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/category_migration_service.dart';
import '../../data/repositories/firebase_category_repository.dart';
import '../../data/datasources/remote/firebase/firebase_category_service.dart';
import 'auth_providers.dart';

/// Migration status for the app
enum MigrationStatus {
  notStarted,
  inProgress,
  completed,
  failed,
  notNeeded,
}

/// Migration state
class MigrationState {
  final MigrationStatus status;
  final String? currentMessage;
  final int current;
  final int total;
  final String? error;

  const MigrationState({
    required this.status,
    this.currentMessage,
    this.current = 0,
    this.total = 0,
    this.error,
  });

  MigrationState copyWith({
    MigrationStatus? status,
    String? currentMessage,
    int? current,
    int? total,
    String? error,
  }) {
    return MigrationState(
      status: status ?? this.status,
      currentMessage: currentMessage ?? this.currentMessage,
      current: current ?? this.current,
      total: total ?? this.total,
      error: error ?? this.error,
    );
  }

  double get progress => total > 0 ? current / total : 0;
}

/// Controller for category migration
class CategoryMigrationController extends StateNotifier<MigrationState> {
  final Ref ref;

  CategoryMigrationController(this.ref) : super(const MigrationState(status: MigrationStatus.notStarted));

  /// Start the migration process
  Future<void> startMigration() async {
    // Check if user is logged in using isAuthenticated provider
    final authRepo = ref.read(authRepositoryProvider);
    final currentUserResult = await authRepo.getCurrentUser();

    final isLoggedIn = currentUserResult.fold(
      (failure) => false,
      (user) => user != null,
    );

    if (!isLoggedIn) {
      state = const MigrationState(
        status: MigrationStatus.failed,
        error: 'User not logged in',
      );
      return;
    }

    // Check if migration is needed
    final needsMigration = await CategoryMigrationService.needsMigration();
    if (!needsMigration) {
      state = const MigrationState(status: MigrationStatus.notNeeded);
      return;
    }

    // Get category count
    final total = await CategoryMigrationService.getMigratableCount();

    state = MigrationState(
      status: MigrationStatus.inProgress,
      current: 0,
      total: total,
      currentMessage: 'Preparing to migrate $total category(ies)...',
    );

    // Create repository
    final firebaseService = FirebaseCategoryService();
    final repository = FirebaseCategoryRepository(firebaseService);

    // Run migration
    final result = await CategoryMigrationService.migrate(
      onProgress: (message, current, total) async {
        state = MigrationState(
          status: MigrationStatus.inProgress,
          currentMessage: message,
          current: current,
          total: total,
        );
      },
      repository: repository,
    );

    if (result.success) {
      state = MigrationState(
        status: MigrationStatus.completed,
        currentMessage: 'Migration complete! Migrated ${result.migratedCount} category(ies).',
        current: result.migratedCount,
        total: result.migratedCount + result.failedCount,
      );
    } else {
      state = MigrationState(
        status: MigrationStatus.failed,
        error: result.errors.join(', '),
        currentMessage: 'Migration failed',
      );
    }
  }

  /// Reset migration (for testing)
  Future<void> reset() async {
    await CategoryMigrationService.resetMigration();
    state = const MigrationState(status: MigrationStatus.notStarted);
  }
}

/// Provider for category migration controller
final categoryMigrationProvider = StateNotifierProvider<CategoryMigrationController, MigrationState>((ref) {
  return CategoryMigrationController(ref);
});

/// Provider that checks if migration is needed
final needsMigrationProvider = FutureProvider<bool>((ref) async {
  return await CategoryMigrationService.needsMigration();
});

/// Provider that gets migration count
final migrationCountProvider = FutureProvider<int>((ref) async {
  return await CategoryMigrationService.getMigratableCount();
});
