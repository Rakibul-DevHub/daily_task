//
// import 'package:askfemi/features/group_user/visions/ugc_home/ugc_task_details/ugc_task_model/ugc_sub_task_model.dart';
// enum TaskStatus { pending, inProgress, completed }
// class UgcTask {
//   final String title;
//   final String description;
//   final String time;
//   final int? totalSubtasks;
//   final int? completedSubtasks;
//   final TaskStatus status;
//   final DateTime createdAt;
//   final DateTime startTime;
//   final DateTime? completedTime;
//   final List<UgcSubTask> subtasks;
//
//   UgcTask({
//     required this.title,
//     required this.description,
//     required this.time,
//     this.totalSubtasks,
//     this.completedSubtasks,
//     required this.status,
//     required this.createdAt,
//     required this.startTime,
//     this.completedTime,
//     this.subtasks = const [],
//   });
//
//   // 👇 Add this helper method
//   UgcTask copyWith({
//     String? title,
//     String? description,
//     String? time,
//     int? totalSubtasks,
//     int? completedSubtasks,
//     TaskStatus? status,
//     DateTime? createdAt,
//     DateTime? startTime,
//     DateTime? completedTime,
//     List<UgcSubTask>? subtasks,
//   }) {
//     return UgcTask(
//       title: title ?? this.title,
//       description: description ?? this.description,
//       time: time ?? this.time,
//       totalSubtasks: totalSubtasks ?? this.totalSubtasks,
//       completedSubtasks: completedSubtasks ?? this.completedSubtasks,
//       status: status ?? this.status,
//       createdAt: createdAt ?? this.createdAt,
//       startTime: startTime ?? this.startTime,
//       completedTime: completedTime ?? this.completedTime,
//       subtasks: subtasks ?? this.subtasks,
//     );
//   }
// }

import 'package:askfemi/features/group_user/visions/ugc_home/ugc_task_details/ugc_task_model/ugc_sub_task_model.dart';

enum TaskStatus { pending, inProgress, completed }

class UgcTask {
  final String title;
  final String description;
  final String time;
  final int? totalSubtasks;
  final int? completedSubtasks;
  final TaskStatus status;
  final DateTime createdAt;
  final DateTime startTime;
  final DateTime? completedTime;
  final List<UgcSubTask> subtasks;
  final String? assignedBy; // null = self task, otherwise name of person who assigned
  final List<String>? groupMembers; // List of avatar image paths for group tasks

  UgcTask({
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
    this.assignedBy,
    this.groupMembers,
  });

  // 👇 Updated copyWith method with new fields
  UgcTask copyWith({
    String? title,
    String? description,
    String? time,
    int? totalSubtasks,
    int? completedSubtasks,
    TaskStatus? status,
    DateTime? createdAt,
    DateTime? startTime,
    DateTime? completedTime,
    List<UgcSubTask>? subtasks,
    String? assignedBy,
    List<String>? groupMembers,
  }) {
    return UgcTask(
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
      assignedBy: assignedBy ?? this.assignedBy,
      groupMembers: groupMembers ?? this.groupMembers,
    );
  }
}