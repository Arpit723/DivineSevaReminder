import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/task/task_priority.dart';
import '../../../domain/entities/task/task_status.dart';
import '../../providers/task_filter_provider.dart';
import '../../providers/category_provider.dart';

/// Bottom sheet dialog for advanced task filtering
class TaskFilterDialog extends ConsumerStatefulWidget {
  const TaskFilterDialog({super.key});

  @override
  ConsumerState<TaskFilterDialog> createState() => _TaskFilterDialogState();
}

class _TaskFilterDialogState extends ConsumerState<TaskFilterDialog> {
  @override
  Widget build(BuildContext context) {
    final filterState = ref.watch(taskFilterStateProvider);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text(
                    'Filter Tasks',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  if (filterState.hasActiveFilters)
                    TextButton(
                      onPressed: () {
                        ref.read(taskFilterStateProvider.notifier).clearFilters();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Clear All',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Filter options
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status filter
                    const _FilterSectionTitle(
                      title: 'Status',
                      icon: Icons.pending_actions,
                    ),
                    const SizedBox(height: 8),
                    _StatusFilterChips(
                      selectedStatus: filterState.status,
                      onStatusSelected: (status) {
                        ref
                            .read(taskFilterStateProvider.notifier)
                            .setStatusFilter(status);
                      },
                    ),

                    const SizedBox(height: 24),

                    // Priority filter
                    const _FilterSectionTitle(
                      title: 'Priority',
                      icon: Icons.flag,
                    ),
                    const SizedBox(height: 8),
                    _PriorityFilterChips(
                      selectedPriority: filterState.priority,
                      onPrioritySelected: (priority) {
                        ref
                            .read(taskFilterStateProvider.notifier)
                            .setPriorityFilter(priority);
                      },
                    ),

                    const SizedBox(height: 24),

                    // Category filter
                    const _FilterSectionTitle(
                      title: 'Category',
                      icon: Icons.category,
                    ),
                    const SizedBox(height: 8),
                    _CategoryFilter(
                      selectedCategoryId: filterState.categoryId,
                      selectedCustomCategoryId: filterState.customCategoryId,
                      onCategorySelected: (categoryId) {
                        ref
                            .read(taskFilterStateProvider.notifier)
                            .setCategoryFilter(categoryId);
                      },
                      onCustomCategorySelected: (customCategoryId) {
                        ref
                            .read(taskFilterStateProvider.notifier)
                            .setCustomCategoryFilter(customCategoryId);
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Close button
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade200, width: 1),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B0000),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterSectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const _FilterSectionTitle({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF8B0000)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _StatusFilterChips extends StatelessWidget {
  final TaskStatus? selectedStatus;
  final Function(TaskStatus?) onStatusSelected;

  const _StatusFilterChips({
    required this.selectedStatus,
    required this.onStatusSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _FilterChoiceChip(
          label: 'All',
          isSelected: selectedStatus == null,
          onSelected: () => onStatusSelected(null),
        ),
        ...TaskStatus.values.map((status) => _FilterChoiceChip(
              label: status.label,
              isSelected: selectedStatus == status,
              onSelected: () => onStatusSelected(status),
            )),
      ],
    );
  }
}

class _PriorityFilterChips extends StatelessWidget {
  final TaskPriority? selectedPriority;
  final Function(TaskPriority?) onPrioritySelected;

  const _PriorityFilterChips({
    required this.selectedPriority,
    required this.onPrioritySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _FilterChoiceChip(
          label: 'All',
          isSelected: selectedPriority == null,
          onSelected: () => onPrioritySelected(null),
        ),
        ...TaskPriority.values.map((priority) => _FilterChoiceChip(
              label: priority.label,
              isSelected: selectedPriority == priority,
              onSelected: () => onPrioritySelected(priority),
              icon: priority.icon,
              iconColor: priority.color,
            )),
      ],
    );
  }
}

class _CategoryFilter extends ConsumerWidget {
  final String? selectedCategoryId;
  final String? selectedCustomCategoryId;
  final Function(String?) onCategorySelected;
  final Function(String?) onCustomCategorySelected;

  const _CategoryFilter({
    required this.selectedCategoryId,
    required this.selectedCustomCategoryId,
    required this.onCategorySelected,
    required this.onCustomCategorySelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(allCategoriesProvider);

    return categoriesAsync.when(
      data: (categories) {
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _FilterChoiceChip(
              label: 'All',
              isSelected: selectedCategoryId == null && selectedCustomCategoryId == null,
              onSelected: () {
                onCategorySelected(null);
                onCustomCategorySelected(null);
              },
            ),
            ...categories.map((category) {
              final isSelected = category.when(
                builtIn: (id, cat) => id == selectedCategoryId,
                custom: (id, name, iconName, colorValue, createdAt) =>
                    id == selectedCustomCategoryId,
              );

              return _FilterChoiceChip(
                label: category.displayName,
                isSelected: isSelected,
                onSelected: () {
                  category.when(
                    builtIn: (id, cat) {
                      onCategorySelected(id);
                      onCustomCategorySelected(null);
                    },
                    custom: (id, name, iconName, colorValue, createdAt) {
                      onCategorySelected(null);
                      onCustomCategorySelected(id);
                    },
                  );
                },
                icon: category.icon,
                iconColor: category.color,
              );
            }),
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (_, __) => const Text('Error loading categories'),
    );
  }
}

class _FilterChoiceChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;
  final IconData? icon;
  final Color? iconColor;

  const _FilterChoiceChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      avatar: icon != null
          ? Icon(
              icon,
              size: 18,
              color: isSelected ? (iconColor ?? Colors.white) : (iconColor ?? Colors.grey),
            )
          : null,
      selectedColor: const Color(0xFF8B0000),
      checkmarkColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black87,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      side: BorderSide(
        color: isSelected ? const Color(0xFF8B0000) : Colors.grey.shade300,
      ),
    );
  }
}

/// Show the filter bottom sheet
void showTaskFilterDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) => const TaskFilterDialog(),
    ),
  );
}
