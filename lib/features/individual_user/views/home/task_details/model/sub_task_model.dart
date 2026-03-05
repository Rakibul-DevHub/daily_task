///=====================
/// subtask_model.dart
///=====================

class SubTask {
  final String title;
  final bool isCompleted;
  final String? duration;

  SubTask({
    required this.title,
    this.isCompleted = false,
    this.duration,
  });

  SubTask copyWith({
    String? title,
    bool? isCompleted,
    String? duration,
  }) {
    return SubTask(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      duration: duration ?? this.duration,
    );
  }
}