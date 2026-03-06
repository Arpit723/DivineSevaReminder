import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// Task priority levels for organizing importance
enum TaskPriority {
  @JsonValue(1)
  p1, // Urgent - Time-sensitive seva (festival preparation)
  @JsonValue(2)
  p2, // High - Important but flexible
  @JsonValue(3)
  p3, // Normal - Regular seva
  @JsonValue(4)
  p4; // Low - Optional, can defer

  /// Get integer value for storage
  int get value {
    switch (this) {
      case TaskPriority.p1:
        return 1;
      case TaskPriority.p2:
        return 2;
      case TaskPriority.p3:
        return 3;
      case TaskPriority.p4:
        return 4;
    }
  }

  /// Human-readable label
  String get label {
    switch (this) {
      case TaskPriority.p1:
        return 'Urgent';
      case TaskPriority.p2:
        return 'High';
      case TaskPriority.p3:
        return 'Normal';
      case TaskPriority.p4:
        return 'Low';
    }
  }

  /// Color for UI indication
  Color get color {
    switch (this) {
      case TaskPriority.p1:
        return const Color(0xFFFF3B30); // Red
      case TaskPriority.p2:
        return const Color(0xFFFF9500); // Orange
      case TaskPriority.p3:
        return const Color(0xFF007AFF); // Blue
      case TaskPriority.p4:
        return const Color(0xFF8E8E93); // Gray
    }
  }

  /// Icon for UI indication
  IconData get icon {
    switch (this) {
      case TaskPriority.p1:
        return Icons.priority_high;
      case TaskPriority.p2:
        return Icons.flag;
      case TaskPriority.p3:
        return Icons.flag_outlined;
      case TaskPriority.p4:
        return Icons.outlined_flag;
    }
  }

  /// XP multiplier for gamification
  double get xpMultiplier {
    switch (this) {
      case TaskPriority.p1:
        return 2.5;
      case TaskPriority.p2:
        return 1.5;
      case TaskPriority.p3:
        return 1.0;
      case TaskPriority.p4:
        return 0.5;
    }
  }

  /// Create priority from integer value
  static TaskPriority fromValue(int value) {
    return TaskPriority.values.firstWhere(
      (p) => p.value == value,
      orElse: () => TaskPriority.p3,
    );
  }
}
