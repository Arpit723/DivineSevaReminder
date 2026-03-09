import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/datasources/remote/firebase/firebase_category_service.dart';
import '../../data/repositories/firebase_category_repository.dart';
import '../../domain/entities/seva/seva_category.dart';
import '../../domain/repositories/category_repository.dart';

part 'category_provider.g.dart';

/// Provider for Firebase category service
@riverpod
FirebaseCategoryService firebaseCategoryService(FirebaseCategoryServiceRef ref) {
  return FirebaseCategoryService();
}

/// Provider for category repository
@riverpod
CategoryRepository categoryRepository(CategoryRepositoryRef ref) {
  final firebaseService = ref.watch(firebaseCategoryServiceProvider);
  return FirebaseCategoryRepository(firebaseService);
}

/// Provider for all categories (built-in + custom)
@riverpod
Stream<List<SevaCategory>> allCategories(AllCategoriesRef ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  return repository.watchAllCategories();
}

/// Provider for custom categories only
@riverpod
Stream<List<SevaCategory>> customCategories(CustomCategoriesRef ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  return repository.watchCustomCategories();
}

/// Provider for built-in categories (synchronous)
@riverpod
List<SevaCategory> builtInCategories(BuiltInCategoriesRef ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  return repository.getBuiltInCategories();
}

/// Helper extension to get category from list by ID
extension CategoryListExtension on List<SevaCategory> {
  SevaCategory? getById(String? id) {
    if (id == null) return null;

    for (final category in this) {
      final match = category.when(
        builtIn: (catId, _) => catId == id,
        custom: (catId, _, ___, ____, _____) => catId == id,
      );
      if (match) return category;
    }
    return null;
  }

  /// Get category display name by ID
  String getNameById(String? id) {
    final category = getById(id);
    return category?.displayName ?? 'Unknown';
  }

  /// Get category icon by ID
  // IconData getIconById(String? id) {
  //   final category = getById(id);
  //   return category?.icon ?? Icons.label;
  // }

  /// Get category color by ID
  // Color getColorById(String? id) {
  //   final category = getById(id);
  //   return category?.color ?? const Color(0xFF8B0000);
  // }
}
