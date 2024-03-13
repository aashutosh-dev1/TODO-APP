class TaskDto {
  final int id;
  final String label;
  final String description;

  /// high-3, medium-2, low-1
  final int priority;
  final int isCompleted;

  TaskDto({
    required this.id,
    required this.label,
    required this.description,
    required this.priority,
    required this.isCompleted,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'label': label,
      'description': description,
      'priority': priority,
      'isCompleted': isCompleted,
    };
  }
}
