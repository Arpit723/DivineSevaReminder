import '../entities/seva/seva_category.dart';

/// Repository interface for Category operations
/// Abstracts the data source from the domain layer
abstract class CategoryRepository {
  /// Watch all categories (built-in + custom) as a stream
  Stream<List<SevaCategory>> watchAllCategories();

  /// Watch only custom categories as a stream
  Stream<List<SevaCategory>> watchCustomCategories();

  /// Get all built-in categories (synchronous)
  List<SevaCategory> getBuiltInCategories();

  /// Get a category by ID (built-in or custom)
  Future<SevaCategory?> getCategoryById(String id);

  /// Create a new custom category
  Future<SevaCategory> createCustomCategory({
    required String name,
    required String iconName,
    required int colorValue,
  });

  /// Update an existing custom category
  Future<void> updateCustomCategory(SevaCategory category);

  /// Delete a custom category by ID
  Future<void> deleteCustomCategory(String id);

  /// Get category count
  Future<int> getCategoryCount();
}
