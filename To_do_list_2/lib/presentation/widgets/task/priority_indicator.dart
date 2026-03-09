import 'package:flutter/material.dart';
import '../../../domain/entities/task/task_priority.dart';

/// Circular icon indicator for task lists
class PriorityIndicator extends StatelessWidget {
  final TaskPriority priority;
  final double size;

  const PriorityIndicator({
    super.key,
    required this.priority,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: priority.color,
        shape: BoxShape.circle,
      ),
      child: Icon(
        priority.icon,
        size: size * 0.6,
        color: Colors.white,
      ),
    );
  }
}

/// Compact badge for priority display
class PriorityBadge extends StatelessWidget {
  final TaskPriority priority;

  const PriorityBadge({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: priority.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: priority.color, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(priority.icon, size: 12, color: priority.color),
          const SizedBox(width: 3),
          Text(
            priority.label,
            style: TextStyle(
              fontSize: 11,
              color: priority.color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
