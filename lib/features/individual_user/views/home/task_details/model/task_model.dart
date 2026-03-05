
import 'package:askfemi/features/individual_user/views/home/task_details/model/sub_task_model.dart';
enum TaskStatus { pending, inProgress, completed }
class Task {
  final String title;
  final String description;
  final String time;
  final int? totalSubtasks;
  final int? completedSubtasks;
  final TaskStatus status;
  final DateTime createdAt;
  final DateTime startTime;
  final DateTime? completedTime;
  final List<SubTask> subtasks;

  Task({
    required this.title,
    required this.description,
    required this.time,
    this.totalSubtasks,
    this.completedSubtasks,
    required this.status,
    required this.createdAt,
    required this.startTime,
    this.completedTime,
    this.subtasks = const [],
  });

  // 👇 Add this helper method
  Task copyWith({
    String? title,
    String? description,
    String? time,
    int? totalSubtasks,
    int? completedSubtasks,
    TaskStatus? status,
    DateTime? createdAt,
    DateTime? startTime,
    DateTime? completedTime,
    List<SubTask>? subtasks,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
      totalSubtasks: totalSubtasks ?? this.totalSubtasks,
      completedSubtasks: completedSubtasks ?? this.completedSubtasks,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      startTime: startTime ?? this.startTime,
      completedTime: completedTime ?? this.completedTime,
      subtasks: subtasks ?? this.subtasks,
    );
  }
}