import 'package:flutter/material.dart';
import '../models/task.dart';
import '../models/custom_category.dart';
import '../services/category_storage_service.dart';

class CategoryListScreen extends StatefulWidget {
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
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  final TextEditingController _categoryController = TextEditingController();
  List<CustomCategory> _customCategories = [];

  @override
  void initState() {
    super.initState();
    _loadCustomCategories();
  }

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _loadCustomCategories() async {
    final categories = await CategoryStorageService.getAllCategories();
    setState(() {
      _customCategories = categories;
    });
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
              onPressed: () async {
                final categoryName = _categoryController.text.trim();
                if (categoryName.isNotEmpty) {
                  // Check if category already exists
                  final exists = await CategoryStorageService.categoryExists(categoryName);

                  if (exists) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Category with this name already exists!'),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  // Create new custom category
                  final newCategory = CustomCategory(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: categoryName,
                    iconName: 'label',
                  );

                  // Save to storage
                  final success = await CategoryStorageService.addCategory(newCategory);

                  if (success) {
                    // Reload categories
                    await _loadCustomCategories();

                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Category "$categoryName" added successfully!'),
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    Navigator.of(context).pop();
                  } else {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to add category. Please try again.'),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B0000),
                foregroundColor: Colors.white,
              ),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Total item count: built-in categories + custom categories
    final totalItemCount = TaskCategory.values.length + _customCategories.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Category List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
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
                  final customCategory = _customCategories[customCategoryIndex];
                  final isSelected = widget.selectedCustomCategoryId == customCategory.id;

                  return Dismissible(
                    key: Key(customCategory.id),
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
                            content: Text('Are you sure you want to delete "${customCategory.name}"?'),
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
                      final success = await CategoryStorageService.deleteCategory(customCategory.id);
                      if (success) {
                        await _loadCustomCategories();
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${customCategory.name} deleted'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      elevation: 1,
                      child: ListTile(
                        leading: const Icon(
                          Icons.label,
                          color: Color(0xFF8B0000),
                          size: 32,
                        ),
                        title: Text(
                          customCategory.name,
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
                            widget.onCustomCategorySelected!(customCategory.id);
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ),
                  );
                }
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
