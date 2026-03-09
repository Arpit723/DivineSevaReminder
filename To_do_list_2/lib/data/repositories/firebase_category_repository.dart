import '../../domain/entities/seva/seva_category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/remote/firebase/firebase_category_service.dart';

/// Firebase implementation of CategoryRepository
/// Handles category operations using Firebase Firestore
class FirebaseCategoryRepository implements CategoryRepository {
  final FirebaseCategoryService _firebaseService;

  FirebaseCategoryRepository(this._firebaseService);

  @override
  Stream<List<SevaCategory>> watchAllCategories() {
    // Combine built-in categories with custom categories from Firebase
    return _firebaseService.watchCustomCategories().map(
      (customCategories) {
        final builtIn = SevaCategory.getAllBuiltIn();
        return [...builtIn, ...customCategories];
      },
    );
  }

  @override
  Stream<List<SevaCategory>> watchCustomCategories() {
    return _firebaseService.watchCustomCategories();
  }

  @override
  List<SevaCategory> getBuiltInCategories() {
    return SevaCategory.getAllBuiltIn();
  }

  @override
  Future<SevaCategory?> getCategoryById(String id) async {
    // Check built-in categories first
    try {
      final builtIn = BuiltInCategory.values.firstWhere((cat) => cat.value == id);
      return SevaCategory.fromBuiltIn(builtIn);
    } catch (_) {
      // Not a built-in category, check custom categories
      return await _firebaseService.getCustomCategoryById(id);
    }
  }

  @override
  Future<SevaCategory> createCustomCategory({
    required String name,
    required String iconName,
    required int colorValue,
  }) async {
    return await _firebaseService.createCustomCategory(
      name: name,
      iconName: iconName,
      colorValue: colorValue,
    );
  }

  @override
  Future<void> updateCustomCategory(SevaCategory category) async {
    await _firebaseService.updateCustomCategory(category);
  }

  @override
  Future<void> deleteCustomCategory(String id) async {
    await _firebaseService.deleteCustomCategory(id);
  }

  @override
  Future<int> getCategoryCount() async {
    // Get count of all categories (built-in + custom)
    final customCategories = await _firebaseService.watchCustomCategories().first;
    return SevaCategory.getAllBuiltIn().length + customCategories.length;
  }
}
