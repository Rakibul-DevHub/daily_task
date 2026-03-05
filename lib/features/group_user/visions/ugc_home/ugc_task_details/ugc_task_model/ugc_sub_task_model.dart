///=====================
/// subtask_model.dart
///=====================

class UgcSubTask {
  final String title;
  final bool isCompleted;
  final String? duration;

  UgcSubTask({
    required this.title,
    this.isCompleted = false,
    this.duration,
  });

  UgcSubTask copyWith({
    String? title,
    bool? isCompleted,
    String? duration,
  }) {
    return UgcSubTask(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      duration: duration ?? this.duration,
    );
  }
}