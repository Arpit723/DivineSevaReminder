import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/custom_category.dart';

class CategoryStorageService {
  static const String _customCategoriesKey = 'custom_categories';

  /// Get all custom categories from local storage
  static Future<List<CustomCategory>> getAllCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final categoriesString = prefs.getString(_customCategoriesKey);

    if (categoriesString == null || categoriesString.isEmpty) {
      return [];
    }

    try {
      final categoriesJson = jsonDecode(categoriesString) as List;
      return categoriesJson.map((json) => CustomCategory.fromJson(json)).toList();
    } catch (e) {
      print('Error loading custom categories: $e');
      return [];
    }
  }

  /// Add a new custom category
  static Future<bool> addCategory(CustomCategory category) async {
    try {
      // Get existing categories
      final categories = await getAllCategories();

      // Check if category with same name already exists
      final exists = categories.any((cat) =>
        cat.name.toLowerCase() == category.name.toLowerCase()
      );

      if (exists) {
        return false; // Category already exists
      }

      // Add new category
      categories.add(category);

      // Save to storage
      await _saveCategories(categories);
      return true;
    } catch (e) {
      print('Error adding category: $e');
      return false;
    }
  }

  /// Delete a custom category by ID
  static Future<bool> deleteCategory(String categoryId) async {
    try {
      final categories = await getAllCategories();
      categories.removeWhere((cat) => cat.id == categoryId);
      await _saveCategories(categories);
      return true;
    } catch (e) {
      print('Error deleting category: $e');
      return false;
    }
  }

  /// Update an existing category
  static Future<bool> updateCategory(CustomCategory updatedCategory) async {
    try {
      final categories = await getAllCategories();
      final index = categories.indexWhere((cat) => cat.id == updatedCategory.id);

      if (index == -1) {
        return false; // Category not found
      }

      categories[index] = updatedCategory;
      await _saveCategories(categories);
      return true;
    } catch (e) {
      print('Error updating category: $e');
      return false;
    }
  }

  /// Check if a category name already exists
  static Future<bool> categoryExists(String categoryName) async {
    final categories = await getAllCategories();
    return categories.any((cat) =>
      cat.name.toLowerCase() == categoryName.toLowerCase()
    );
  }

  /// Clear all custom categories
  static Future<void> clearAllCategories() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_customCategoriesKey);
  }

  /// Private helper to save categories to storage
  static Future<void> _saveCategories(List<CustomCategory> categories) async {
    final prefs = await SharedPreferences.getInstance();
    final categoriesJson = categories.map((cat) => cat.toJson()).toList();
    await prefs.setString(_customCategoriesKey, jsonEncode(categoriesJson));
  }

  /// Get category by ID
  static Future<CustomCategory?> getCategoryById(String categoryId) async {
    final categories = await getAllCategories();
    try {
      return categories.firstWhere((cat) => cat.id == categoryId);
    } catch (e) {
      return null;
    }
  }
}
