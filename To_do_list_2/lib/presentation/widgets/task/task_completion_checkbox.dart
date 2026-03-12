import 'package:flutter/material.dart';

/// Radio/Checkbox widget for task completion
class TaskCompletionCheckbox extends StatelessWidget {
  final bool isCompleted;
  final VoidCallback onToggle;

  const TaskCompletionCheckbox({
    super.key,
    required this.isCompleted,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onToggle,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 48,
        height: 48,
        alignment: Alignment.center,
        child: Icon(
          isCompleted ? Icons.check_circle : Icons.circle_outlined,
          color: isCompleted
              ? const Color(0xFF8B0000) // Completed: Dark red
              : Colors.grey.shade400, // Not completed: Grey
          size: 28,
        ),
      ),
    );
  }
}
