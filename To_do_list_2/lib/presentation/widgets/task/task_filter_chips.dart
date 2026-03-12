import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/task_filter_provider.dart';

/// Horizontal scrollable filter chips
class TaskFilterChips extends ConsumerWidget {
  const TaskFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(taskFilterStateProvider);

    if (!filterState.hasActiveFilters) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          // Category filter chips (if both built-in and custom)
          // Note: Only one can be active at a time
          if (filterState.categoryId != null || filterState.customCategoryId != null)
            _FilterChip(
              label: 'Category Filter', // Would show actual category name
              onDeleted: () {
                ref.read(taskFilterStateProvider.notifier).clearCategory();
              },
              icon: Icons.category,
            ),

          // Tags filter chips
          ...filterState.tags.map((tag) => _FilterChip(
                label: '#$tag',
                onDeleted: () {
                  ref.read(taskFilterStateProvider.notifier).removeTagFilter(tag);
                },
                icon: Icons.tag,
              )),

          // Clear all chip
          _FilterChip(
            label: 'Clear All',
            onDeleted: () {
              ref.read(taskFilterStateProvider.notifier).clearFilters();
            },
            icon: Icons.clear_all,
            isDestructive: true,
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final VoidCallback onDeleted;
  final IconData icon;
  final Color? iconColor;
  final bool isDestructive;

  const _FilterChip({
    required this.label,
    required this.onDeleted,
    required this.icon,
    this.iconColor,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: isDestructive ? Colors.red : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        avatar: Icon(
          icon,
          size: 16,
          color: isDestructive ? Colors.red : (iconColor ?? const Color(0xFF8B0000)),
        ),
        onDeleted: onDeleted,
        deleteIconColor: isDestructive ? Colors.red : Colors.grey.shade600,
        backgroundColor: isDestructive ? Colors.red.shade50 : Colors.white,
        side: BorderSide(
          color: isDestructive ? Colors.red : Colors.grey.shade300,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
    );
  }
}
