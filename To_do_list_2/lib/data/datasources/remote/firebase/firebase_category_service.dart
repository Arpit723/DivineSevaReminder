import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../../../domain/entities/seva/seva_category.dart';

/// Firebase Firestore service for Category operations
/// Handles CRUD operations for custom categories in Firebase
class FirebaseCategoryService {
  final FirebaseFirestore? _firestore;
  final firebase_auth.FirebaseAuth? _auth;

  FirebaseCategoryService()
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

  /// Get the categories collection reference for current user
  CollectionReference? _getCategoriesCollection() {
    final userId = currentUserId;
    if (userId == null || _firestore == null) return null;
    return _firestore!.collection('users').doc(userId).collection('categories');
  }

  /// Create a new custom category in Firestore
  Future<SevaCategory> createCustomCategory({
    required String name,
    required String iconName,
    required int colorValue,
  }) async {
    if (!isFirebaseAvailable) {
      throw Exception('Firebase is not initialized');
    }

    final userId = currentUserId;
    if (userId == null) {
      throw Exception('No user logged in');
    }

    final categoriesCollection = _getCategoriesCollection();
    if (categoriesCollection == null) {
      throw Exception('Categories collection not available');
    }

    final docRef = categoriesCollection.doc();

    final category = SevaCategory.custom(
      id: docRef.id,
      name: name,
      iconName: iconName,
      colorValue: colorValue,
      createdAt: DateTime.now(),
    );

    await docRef.set({
      'id': category.id,
      'name': name,
      'iconName': iconName,
      'colorValue': colorValue,
      'type': 'custom',
      'createdAt': FieldValue.serverTimestamp(),
    });

    return category;
  }

  /// Update an existing custom category in Firestore
  Future<void> updateCustomCategory(SevaCategory category) async {
    if (!isFirebaseAvailable) {
      throw Exception('Firebase is not initialized');
    }

    final categoriesCollection = _getCategoriesCollection();
    if (categoriesCollection == null) {
      throw Exception('Categories collection not available');
    }

    final docRef = categoriesCollection.doc(category.id);

    // Check if category exists
    final doc = await docRef.get();
    if (!doc.exists) {
      throw Exception('Category not found');
    }

    // Update only custom categories
    final data = doc.data() as Map<String, dynamic>;
    if (data['type'] != 'custom') {
      throw Exception('Cannot update built-in categories');
    }

    await docRef.update({
      'name': category.displayName,
      'iconName': category.when(
        builtIn: (_, __) => 'label',
        custom: (_, __, iconName, ____, _____) => iconName,
      ),
      'colorValue': category.color.value,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Delete a custom category from Firestore
  Future<void> deleteCustomCategory(String categoryId) async {
    if (!isFirebaseAvailable) {
      throw Exception('Firebase is not initialized');
    }

    final categoriesCollection = _getCategoriesCollection();
    if (categoriesCollection == null) {
      throw Exception('Categories collection not available');
    }

    // Check if it's a custom category before deleting
    final doc = await categoriesCollection.doc(categoryId).get();
    if (!doc.exists) {
      throw Exception('Category not found');
    }

    final data = doc.data() as Map<String, dynamic>;
    if (data['type'] != 'custom') {
      throw Exception('Cannot delete built-in categories');
    }

    await categoriesCollection.doc(categoryId).delete();
  }

  /// Watch all custom categories for current user as a stream
  Stream<List<SevaCategory>> watchCustomCategories() {
    if (!isFirebaseAvailable) {
      return Stream.value([]);
    }

    final categoriesCollection = _getCategoriesCollection();
    if (categoriesCollection == null) {
      return Stream.value([]);
    }

    return categoriesCollection
        .where('type', isEqualTo: 'custom')
        .snapshots()
        .map((snapshot) {
      final categories = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return SevaCategory.custom(
          id: doc.id,
          name: data['name'] as String,
          iconName: data['iconName'] as String? ?? 'label',
          colorValue: data['colorValue'] as int? ?? 0xFF8B0000,
          createdAt: data['createdAt'] != null
              ? (data['createdAt'] as Timestamp).toDate()
              : DateTime.now(),
        );
      }).toList();

      // Sort client-side by createdAt (ascending)
      categories.sort((a, b) {
        final aDate = a.maybeWhen(
          custom: (id, name, iconName, colorValue, createdAt) => createdAt,
          orElse: () => DateTime.now(),
        ) ?? DateTime.now();
        final bDate = b.maybeWhen(
          custom: (id, name, iconName, colorValue, createdAt) => createdAt,
          orElse: () => DateTime.now(),
        ) ?? DateTime.now();
        return aDate.compareTo(bDate);
      });

      return categories;
    });
  }

  /// Get a custom category by ID
  Future<SevaCategory?> getCustomCategoryById(String categoryId) async {
    if (!isFirebaseAvailable) {
      return null;
    }

    final categoriesCollection = _getCategoriesCollection();
    if (categoriesCollection == null) {
      return null;
    }

    final doc = await categoriesCollection.doc(categoryId).get();
    if (!doc.exists) {
      return null;
    }

    final data = doc.data() as Map<String, dynamic>;
    if (data['type'] != 'custom') {
      return null;
    }

    return SevaCategory.custom(
      id: doc.id,
      name: data['name'] as String,
      iconName: data['iconName'] as String? ?? 'label',
      colorValue: data['colorValue'] as int? ?? 0xFF8B0000,
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }
}
