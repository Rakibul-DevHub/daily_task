import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../views/home/controller/task_controller.dart';
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
  final screenWidth = MediaQuery.of(context).size.width;
  final progressBarWidth = screenWidth * 0.075;

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
    if (task.totalSubtasks > 0 && task.completedSubtasks > 0) {
      return (task.completedSubtasks / task.totalSubtasks).clamp(0.0, 1.0);
    }
    return 0.0;
  }

  // Handle Start button tap - Update only this task locally
  void _handleStartTask() async {
    final taskController = Get.isRegistered<TaskController>()
        ? Get.find<TaskController>()
        : Get.put(TaskController());

    // ✅ FIXED: Pass the current time as startTime
    final success = await taskController.updateTaskStatus(
      task.id,
      'inProgress',
      startTime: DateTime.now(),  // Add this line!
    );

    if (success) {
      // Update only this task's status locally without refreshing the whole list
      final currentTasks = taskController.tasks.toList();
      final index = currentTasks.indexWhere((t) => t.id == task.id);

      if (index != -1) {
        final updatedTask = currentTasks[index].copyWith(
          status: TaskStatus.inProgress,
        );
        currentTasks[index] = updatedTask;
        taskController.tasks.value = currentTasks;
      }

      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text('Task started successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(taskController.errorMessage.value),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  return InkWell(
    onTap: () {
      Get.to(() => TaskDetailsScreen(taskId: task.id), transition: Transition.leftToRight);
    },
    child: Stack(
      children: [
        Container(
          padding: EdgeInsets.all(screenWidth * 0.04),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: screenWidth * 0.015,
                offset: Offset(0, screenWidth * 0.005),
              ),
            ],
            border: Border.all(
              color: AppColors.lightGrey,
              width: screenWidth * 0.00375,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Padding(
                padding: EdgeInsets.only(top: screenWidth * 0.05),
                child: Row(
                  children: [
                    if (task.status == TaskStatus.completed)
                      Icon(
                        Icons.check_circle,
                        color: AppColors.textColorGreen,
                        size: screenWidth * 0.045,
                      ),
                    SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      child: Text(
                        task.title,
                        style: titleTextStyle ??
                            TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.bold,
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
              SizedBox(height: screenWidth * 0.03),

              /// Time + Progress
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: screenWidth * 0.03,
                    color: Colors.grey[500],
                  ),
                  SizedBox(width: screenWidth * 0.01),
                  Expanded(
                    flex: 2,
                    child: Text(
                      task.time,
                      style: timeTextStyle ??
                          TextStyle(
                            fontSize: screenWidth * 0.03,
                            color: Colors.grey[600],
                          ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  if (task.totalSubtasks > 0)
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          Icon(
                            Icons.assignment_outlined,
                            size: screenWidth * 0.03,
                            color: Colors.grey[500],
                          ),
                          SizedBox(width: screenWidth * 0.01),
                          Expanded(
                            flex: 3,
                            child: Text(
                              '${task.completedSubtasks} / ${task.totalSubtasks} subtasks',
                              style: subtaskTextStyle ??
                                  TextStyle(
                                    fontSize: screenWidth * 0.03,
                                    color: Colors.grey[600],
                                  ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Container(
                            width: progressBarWidth,
                            height: screenWidth * 0.015,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(screenWidth * 0.0075),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: getCompletionPercent(),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(screenWidth * 0.0075),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.01),
                          Text(
                            '${(getCompletionPercent() * 100).round()}%',
                            style: percentageTextStyle ??
                                TextStyle(
                                  fontSize: screenWidth * 0.03,
                                  color: Colors.grey[600],
                                ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              SizedBox(height: screenWidth * 0.02),
              const DottedLine(),
              SizedBox(height: screenWidth * 0.02),

              // Bottom chips
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(
                      'Self Task',
                      style: selfTaskTextStyle ??
                          TextStyle(
                            fontSize: screenWidth * 0.03,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                    ),
                    backgroundColor: AppColors.mainBottomNavColor.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.01),
                    ),
                    side: BorderSide(color: AppColors.lightGrey),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.025,
                      vertical: screenWidth * 0.0125,
                    ),
                  ),
                  if (task.status == TaskStatus.pending)
                    GestureDetector(
                      onTap: _handleStartTask,
                      child: Chip(
                        label: Text(
                          'Start',
                          style: startButtonTextStyle ??
                              TextStyle(
                                fontSize: screenWidth * 0.03,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                        ),
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.01),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                          vertical: screenWidth * 0.015,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        /// Status badge
        Positioned(
          top: screenWidth * 0.005,
          right: screenWidth * 0.025,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02,
              vertical: screenWidth * 0.01,
            ),
            decoration: BoxDecoration(
              color: getStatusColor(task.status),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(screenWidth * 0.03),
                bottomRight: Radius.circular(screenWidth * 0.03),
              ),
            ),
            child: Text(
              task.status.name
                  .replaceAll('inProgress', 'In Progress')
                  .toUpperCase(),
              style: statusTextStyle ??
                  TextStyle(
                    fontSize: screenWidth * 0.025,
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