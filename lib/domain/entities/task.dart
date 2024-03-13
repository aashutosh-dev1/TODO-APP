// ignore_for_file: public_member_api_docs, sort_constructors_first
class Task {
  final int id;
  final String label;
  final String description;

  /// high-3, medium-2, low-1
  final int priority;
  final int isCompleted;
  Task({
    required this.id,
    required this.label,
    required this.description,
    required this.priority,
    required this.isCompleted,
  });
}
