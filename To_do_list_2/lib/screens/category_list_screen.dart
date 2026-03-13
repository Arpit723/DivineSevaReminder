import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import '../domain/entities/seva/seva_category.dart';
import '../presentation/providers/category_provider.dart';

class CategoryListScreen extends ConsumerStatefulWidget {
  final TaskCategory? selectedCategory;
  final String? selectedCustomCategoryId;
  final Function(TaskCategory)? onCategorySelected;
  final Function(String)? onCustomCategorySelected;

  const CategoryListScreen({
    super.key,
    this.selectedCategory,
    this.selectedCustomCategoryId,
    this.onCategorySelected,
    this.onCustomCategorySelected,
  });

  @override
  ConsumerState<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends ConsumerState<CategoryListScreen> {
  final TextEditingController _categoryController = TextEditingController();
  bool _isCreating = false;

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  void _showAddCategoryDialog() {
    _categoryController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Category'),
          content: TextField(
            controller: _categoryController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter category name...',
              labelText: 'Category Name',
            ),
            autofocus: true,
            textCapitalization: TextCapitalization.words,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _isCreating
                  ? null
                  : () async {
                      final categoryName = _categoryController.text.trim();
                      if (categoryName.isNotEmpty) {
                        setState(() {
                          _isCreating = true;
                        });

                        // Get repository
                        final repository = ref.read(categoryRepositoryProvider);

                        // Check if category already exists by watching the stream
                        final categoriesStream = repository.watchCustomCategories();
                        final categories = await categoriesStream.first;

                        final exists = categories.any((cat) {
                          return cat.maybeWhen(
                            custom: (id, name, iconName, colorValue, createdAt) =>
                                name.toLowerCase() == categoryName.toLowerCase(),
                            orElse: () => false,
                          );
                        });

                        if (exists) {
                          if (!mounted) return;
                          setState(() {
                            _isCreating = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Category with this name already exists!'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        try {
                          await repository.createCustomCategory(
                            name: categoryName,
                            iconName: 'label',
                            colorValue: 0xFF8B0000,
                          );

                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Category "$categoryName" added successfully!'),
                              backgroundColor: Colors.green,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                          Navigator.of(context).pop();
                        } catch (e) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to add category: $e'),
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        } finally {
                          if (mounted) {
                            setState(() {
                              _isCreating = false;
                            });
                          }
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B0000),
                foregroundColor: Colors.white,
              ),
              child: _isCreating
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteCategory(SevaCategory category) async {
    final repository = ref.read(categoryRepositoryProvider);

    // Get category name for confirmation
    final categoryName = category.displayName;

    try {
      await repository.deleteCustomCategory(category.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$categoryName deleted'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete category: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch custom categories from Firebase
    final customCategoriesAsync = ref.watch(customCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Category List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: customCategoriesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading categories: $error',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
              data: (customCategories) {
                // Total item count: built-in categories + custom categories
                final totalItemCount = TaskCategory.values.length + customCategories.length;

                if (totalItemCount == 0) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.category_outlined, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'No categories available',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: totalItemCount,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    // Display built-in categories first
                    if (index < TaskCategory.values.length) {
                      final category = TaskCategory.values[index];
                      final isSelected = widget.selectedCategory == category && widget.selectedCustomCategoryId == null;

                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        elevation: 1,
                        child: ListTile(
                          leading: Icon(
                            _getCategoryIcon(category),
                            color: const Color(0xFF8B0000),
                            size: 32,
                          ),
                          title: Text(
                            category.name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                          trailing: isSelected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF8B0000),
                                  size: 24,
                                )
                              : null,
                          onTap: () {
                            if (widget.onCategorySelected != null) {
                              widget.onCategorySelected!(category);
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      );
                    } else {
                      // Display custom categories
                      final customCategoryIndex = index - TaskCategory.values.length;
                      final customCategory = customCategories[customCategoryIndex];
                      final categoryId = customCategory.maybeWhen(
                        custom: (id, _, ___, ____, _____) => id,
                        orElse: () => '',
                      );
                      final isSelected = widget.selectedCustomCategoryId == categoryId;

                      final categoryIcon = customCategory.icon;
                      final categoryName = customCategory.displayName;
                      final categoryColor = customCategory.color;

                      return Dismissible(
                        key: Key(categoryId),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.delete, color: Colors.white),
                            ],
                          ),
                        ),
                        confirmDismiss: (direction) async {
                          // Show confirmation dialog
                          return await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Delete Category'),
                                content: Text('Are you sure you want to delete "$categoryName"?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        onDismissed: (direction) async {
                          await _deleteCategory(customCategory);
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          elevation: 1,
                          child: ListTile(
                            leading: Icon(
                              categoryIcon,
                              color: categoryColor,
                              size: 32,
                            ),
                            title: Text(
                              categoryName,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                            trailing: isSelected
                                ? const Icon(
                                    Icons.check_circle,
                                    color: Color(0xFF8B0000),
                                    size: 24,
                                  )
                                : null,
                            onTap: () {
                              if (widget.onCustomCategorySelected != null) {
                                widget.onCustomCategorySelected!(categoryId);
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _showAddCategoryDialog,
                icon: const Icon(Icons.add),
                label: const Text('Add New Category'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B0000),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 17),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(TaskCategory category) {
    switch (category) {
      case TaskCategory.transportation:
        return Icons.directions_car;
      case TaskCategory.food:
        return Icons.restaurant;
      case TaskCategory.bills:
        return Icons.receipt_long;
      case TaskCategory.bigExpenditure:
        return Icons.attach_money;
      case TaskCategory.medicines:
        return Icons.medical_services;
      case TaskCategory.centerSeva:
        return Icons.business;
    }
  }
}
