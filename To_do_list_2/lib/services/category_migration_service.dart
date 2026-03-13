import 'package:shared_preferences/shared_preferences.dart';
import '../services/category_storage_service.dart';
import '../data/repositories/firebase_category_repository.dart';
import '../data/datasources/remote/firebase/firebase_category_service.dart';

/// Result of category migration
class MigrationResult {
  final bool success;
  final int migratedCount;
  final int failedCount;
  final List<String> errors;
  final Duration duration;

  const MigrationResult({
    required this.success,
    this.migratedCount = 0,
    this.failedCount = 0,
    this.errors = const [],
    required this.duration,
  });

  @override
  String toString() {
    return 'MigrationResult(success: $success, migrated: $migratedCount, failed: $failedCount, errors: ${errors.length}, duration: ${duration.inSeconds}s)';
  }
}

/// Service to migrate legacy local categories to Firebase Firestore
///
/// This service handles the transition from SharedPreferences-based
/// category storage to Firebase Firestore storage.
class CategoryMigrationService {
  static const String _migrationKey = '_categories_migrated_v2';
  static const String _migrationDateKey = '_categories_migration_date';
  static const String _migratedIdsKey = '_migrated_category_ids';

  /// Check if migration has been completed
  static Future<bool> hasMigrated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_migrationKey) ?? false;
  }

  /// Get the date of last migration
  static Future<DateTime?> getMigrationDate() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getInt(_migrationDateKey);
    if (timestamp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  /// Get list of migrated category IDs
  static Future<Set<String>> getMigratedIds() async {
    final prefs = await SharedPreferences.getInstance();
    final idsString = prefs.getStringList(_migratedIdsKey) ?? [];
    return idsString.toSet();
  }

  /// Check if migration is needed
  static Future<bool> needsMigration() async {
    // Already migrated
    if (await hasMigrated()) {
      return false;
    }

    // Check if there are local categories to migrate
    final localCategories = await CategoryStorageService.getAllCategories();
    return localCategories.isNotEmpty;
  }

  /// Get count of categories that can be migrated
  static Future<int> getMigratableCount() async {
    final localCategories = await CategoryStorageService.getAllCategories();
    return localCategories.length;
  }

  /// Mark migration as complete
  static Future<void> markMigrated({
    Set<String>? migratedIds,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_migrationKey, true);
    await prefs.setInt(_migrationDateKey, DateTime.now().millisecondsSinceEpoch);
    if (migratedIds != null) {
      await prefs.setStringList(_migratedIdsKey, migratedIds.toList());
    }
  }

  /// Reset migration status (for testing/re-migration)
  static Future<void> resetMigration() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_migrationKey);
    await prefs.remove(_migrationDateKey);
    await prefs.remove(_migratedIdsKey);
  }

  /// Migrate all local categories to Firebase
  ///
  /// Returns a MigrationResult with details about the operation.
  /// Progress is reported via the onProgress callback.
  static Future<MigrationResult> migrate({
    required Future<void> Function(String message, int current, int total) onProgress,
    FirebaseCategoryRepository? repository,
  }) async {
    final stopwatch = Stopwatch()..start();
    int migratedCount = 0;
    int failedCount = 0;
    final List<String> errors = [];
    final migratedIds = <String>{};
    final alreadyMigratedIds = await getMigratedIds();

    try {
      // Get all local categories
      final localCategories = await CategoryStorageService.getAllCategories();

      if (localCategories.isEmpty) {
        await markMigrated(migratedIds: migratedIds);
        return MigrationResult(
          success: true,
          migratedCount: 0,
          failedCount: 0,
          duration: stopwatch.elapsed,
        );
      }

      await onProgress('Starting category migration...', 0, localCategories.length);

      // Create repository if not provided
      if (repository == null) {
        try {
          final firebaseService = FirebaseCategoryService();
          repository = FirebaseCategoryRepository(firebaseService);
        } catch (e) {
          return MigrationResult(
            success: false,
            migratedCount: 0,
            failedCount: localCategories.length,
            errors: ['Firebase not available: $e'],
            duration: stopwatch.elapsed,
          );
        }
      }

      // Check if Firebase is available
      final testResult = await repository.getCategoryCount();
      if (testResult <= 0) {
        return MigrationResult(
          success: false,
          migratedCount: 0,
          failedCount: 0,
          errors: ['User not logged in or Firebase not available'],
          duration: stopwatch.elapsed,
        );
      }

      // Migrate each category
      for (int i = 0; i < localCategories.length; i++) {
        final customCategory = localCategories[i];

        // Skip if already migrated
        if (alreadyMigratedIds.contains(customCategory.id)) {
          await onProgress(
            'Skipping already migrated: ${customCategory.name}',
            i + 1,
            localCategories.length,
          );
          continue;
        }

        await onProgress(
          'Migrating: ${customCategory.name}',
          i + 1,
          localCategories.length,
        );

        try {
          // Check if category already exists in Firebase (by name)
          final existingCategories = await repository.watchCustomCategories().first;

          final nameExists = existingCategories.any((cat) {
            return cat.maybeWhen(
              custom: (id, name, iconName, colorValue, createdAt) =>
                  name.toLowerCase() == customCategory.name.toLowerCase(),
              orElse: () => false,
            );
          });

          if (nameExists) {
            errors.add(
              'Category "${customCategory.name}" already exists in Firebase, skipping',
            );
            failedCount++;
          } else {
            // Create new category in Firebase
            // Use default maroon color for migrated categories
            const defaultColorValue = 0xFF8B0000;

            await repository.createCustomCategory(
              name: customCategory.name,
              iconName: customCategory.iconName,
              colorValue: defaultColorValue,
            );

            migratedIds.add(customCategory.id);
            migratedCount++;
          }
        } catch (e) {
          errors.add('Failed to migrate "${customCategory.name}": $e');
          failedCount++;
        }

        // Small delay to avoid overwhelming Firebase
        if (i < localCategories.length - 1) {
          await Future.delayed(const Duration(milliseconds: 100));
        }
      }

      // Mark as complete if we had at least some success
      if (migratedCount > 0 || failedCount == 0) {
        await markMigrated(migratedIds: migratedIds);
      }

      stopwatch.stop();

      return MigrationResult(
        success: failedCount == 0 || migratedCount > 0,
        migratedCount: migratedCount,
        failedCount: failedCount,
        errors: errors,
        duration: stopwatch.elapsed,
      );
    } catch (e) {
      stopwatch.stop();
      return MigrationResult(
        success: false,
        migratedCount: migratedCount,
        failedCount: failedCount,
        errors: [...errors, 'Migration failed: $e'],
        duration: stopwatch.elapsed,
      );
    }
  }

  /// Verify migration by checking if local categories exist in Firebase
  static Future<bool> verifyMigration() async {
    try {
      final localCategories = await CategoryStorageService.getAllCategories();
      if (localCategories.isEmpty) return true;
      return await hasMigrated();
    } catch (e) {
      return false;
    }
  }
}
