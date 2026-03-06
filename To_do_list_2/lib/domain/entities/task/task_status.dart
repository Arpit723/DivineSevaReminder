/// Task status representing the workflow state
enum TaskStatus {
  /// Task is not yet started
  pending,

  /// Task is currently being worked on
  inProgress,

  /// Task has been completed
  completed,

  /// Task has been archived (no longer active)
  archived;

  String get label {
    switch (this) {
      case TaskStatus.pending:
        return 'Pending';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.completed:
        return 'Completed';
      case TaskStatus.archived:
        return 'Archived';
    }
  }

  /// Whether this status represents an active task
  bool get isActive => this == TaskStatus.pending || this == TaskStatus.inProgress;

  /// Whether this status represents a completed task
  bool get isCompleted => this == TaskStatus.completed || this == TaskStatus.archived;

  /// Legacy support - convert to old status names
  String get legacyName {
    switch (this) {
      case TaskStatus.pending:
        return 'Assigned';
      case TaskStatus.inProgress:
        return 'Started';
      case TaskStatus.completed:
        return 'Completed';
      case TaskStatus.archived:
        return 'Archived';
    }
  }

  /// Create from legacy status string
  static TaskStatus fromLegacyString(String? statusString) {
    if (statusString == null) return TaskStatus.pending;

    final normalized = statusString.toLowerCase();
    switch (normalized) {
      case 'assigned':
      case 'pending':
        return TaskStatus.pending;
      case 'started':
      case 'inprogress':
      case 'in_progress':
        return TaskStatus.inProgress;
      case 'completed':
        return TaskStatus.completed;
      case 'archived':
        return TaskStatus.archived;
      default:
        return TaskStatus.pending;
    }
  }
}
