import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../views/home/task_details/model/task_model.dart';
import '../views/home/task_details/task_details_screen.dart';
import 'dotted_line_widget.dart';

Widget buildTaskCard({
  required BuildContext context,
  required Task task,
  TextStyle? titleTextStyle,
  TextStyle? timeTextStyle,
  TextStyle? subtaskTextStyle,
  TextStyle? percentageTextStyle,
  TextStyle? statusTextStyle,
  TextStyle? selfTaskTextStyle,
  TextStyle? startButtonTextStyle,
}) {
  const double progressBarWidth = 30;

  // Status color
  Color getStatusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return AppColors.pendingStatusColor;
      case TaskStatus.inProgress:
        return AppColors.inProgressStatusColor;
      case TaskStatus.completed:
        return AppColors.completedStatusColor;
    }
  }

  Color getStatusTextColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return AppColors.black;
      case TaskStatus.inProgress:
        return AppColors.textColorBlue;
      case TaskStatus.completed:
        return AppColors.textColorGreen;
    }
  }

  double getCompletionPercent() {
    if (task.totalSubtasks != null &&
        task.totalSubtasks! > 0 &&
        task.completedSubtasks != null) {
      return (task.completedSubtasks! / task.totalSubtasks!).clamp(0.0, 1.0);
    }
    return 0.0;
  }

  return InkWell(
    onTap: () {
      Get.to(() => TaskDetailsScreen(task: task),transition: Transition.leftToRight);
    },
    child: Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: AppColors.lightGrey,
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    if (task.status == TaskStatus.completed)
                      Icon(Icons.check_circle, color: AppColors.textColorGreen),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        task.title,
                        style: titleTextStyle ??
                            TextStyle(
                              fontSize: 16,
                              fontWeight:FontWeight.bold ,
                              color: AppColors.black,
                              decoration: task.status == TaskStatus.completed
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              /// Time + Progress
              Row(
                children: [
                  Icon(Icons.access_time, size: 12, color: Colors.grey[500]),
                  // const SizedBox(width: 4),
                  Text(
                    task.time,
                    style: timeTextStyle ??
                        TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(width: 12),
                  if (task.totalSubtasks != null &&
                      task.totalSubtasks! > 0 &&
                      task.completedSubtasks != null)
                    Row(
                      children: [
                        Icon(Icons.assignment_outlined,
                            size: 12, color: Colors.grey[500]),
                        // const SizedBox(width: 4),
                        Text(
                          '${task.completedSubtasks} / ${task.totalSubtasks} subtasks',
                          style: subtaskTextStyle ??
                              TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: progressBarWidth,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: getCompletionPercent(),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${(getCompletionPercent() * 100).round()}% Completed',
                          style: percentageTextStyle ??
                              TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                ],
              ),

              const SizedBox(height: 8),
              const DottedLine(),
              const SizedBox(height: 8),

              // Bottom chips
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(
                      'Self Task',
                      style: selfTaskTextStyle ??
                          TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor),
                    ),
                    backgroundColor: AppColors.mainBottomNavColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    side: BorderSide(color: AppColors.lightGrey),
                  ),

                  if (task.status == TaskStatus.pending)
                    Chip(
                      label: Text(
                        'Start',
                        style: startButtonTextStyle ??
                            TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                      ),
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                ],
              ),
            ],
          ),
        ),

        /// Status badge
        Positioned(
          top: 0,
          right: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: getStatusColor(task.status),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Text(
              task.status.name
                  .replaceAll('inProgress', 'In Progress')
                  .toUpperCase(),
              style: statusTextStyle ??
                  TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: getStatusTextColor(task.status),
                  ),
            ),
          ),
        ),
      ],
    ),
  );
}

