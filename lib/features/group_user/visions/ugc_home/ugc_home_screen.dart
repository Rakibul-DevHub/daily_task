import 'package:askfemi/features/group_user/visions/ugc_home/ugc_task_details/ugc_task_model/ugc_sub_task_model.dart';
import 'package:askfemi/features/group_user/visions/ugc_home/ugc_task_details/ugc_task_model/ugc_task_model.dart';
import 'package:askfemi/features/individual_user/widget/dotted_line_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_texts_style.dart';
import '../../../individual_user/views/notification/notification_screen.dart';

class UgcHomeScreen extends StatelessWidget {
  final VoidCallback onAddTaskPressed;

  const UgcHomeScreen({super.key, required this.onAddTaskPressed});

  @override
  Widget build(BuildContext context) {
    final tasks = _getTasks();
    final isEmptyState = tasks.isEmpty;

    return Scaffold(
      backgroundColor: isEmptyState ? Colors.white : AppColors.backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// Collapsible App Bar (with dynamic background for empty state)
          _buildSliverAppBar(isEmptyState),

          /// Daily Progress Section (only shown when tasks exist)
          if (!isEmptyState)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: _buildDailyProgress(tasks),
              ),
            ),

          /// Pinned Tasks Header (only shown when tasks exist)
          if (!isEmptyState) _buildPinnedTasksHeader(tasks),

          /// Empty State Content OR Tasks List
          _buildTasksContent(context, tasks, isEmptyState),

          /// Bottom Padding
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(bool isEmptyState) {
    return SliverAppBar(
      expandedHeight: 80,
      floating: false,
      pinned: true,
      stretch: true,
      surfaceTintColor: Colors.transparent,
      backgroundColor: isEmptyState ? Colors.white : AppColors.backgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
        background: Container(
          color: isEmptyState ? Colors.white : AppColors.backgroundColor,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  foregroundImage: AssetImage(
                    "assets/images/dummy_user_image.png",
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Welcome back!',
                      style: AppTextStyles.smallText.copyWith(
                        color: isEmptyState ? Colors.grey[600] : null,
                      ),
                    ),
                    Text(
                      'Rakibul',
                      style: AppTextStyles.defaultTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isEmptyState ? Colors.black87 : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, bottom: 8),
              child: InkWell(
                onTap: () => Get.to(
                  () => const NotificationScreen(),
                  transition: Transition.fadeIn,
                ),
                child: SvgPicture.asset(
                  "assets/icons/notification_rounded.svg",
                  fit: BoxFit.fitHeight,
                  height: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyProgress(List<UgcTask> tasks) {
    // Calculate progress from tasks
    final totalTasks = tasks.length;
    final completedTasks = tasks
        .where((task) => task.status == TaskStatus.completed)
        .length;
    final progress = totalTasks > 0 ? completedTasks / totalTasks : 0;

    return Card(
      color: AppColors.backgroundColor,
      elevation: 1,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Daily Progress',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: 'Plus Jakarta Sans',
                  ),
                ),
                Chip(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  label: Text(
                    '$completedTasks / $totalTasks',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 12,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: AppColors.mainBottomNavColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  side: const BorderSide(width: 0, color: Colors.transparent),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: 1 / 4,
                    backgroundColor: AppColors.grey.withValues(alpha: 0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(2),
                    minHeight: 12,
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${totalTasks - completedTasks} tasks remaining. You\'ve got this!',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.grey,
                fontFamily: 'Plus Jakarta Sans',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinnedTasksHeader(List<UgcTask> tasks) {
    // Calculate active tasks
    final activeTasks = tasks
        .where((task) => task.status != TaskStatus.completed)
        .length;

    return SliverPersistentHeader(
      pinned: true,
      delegate: _TasksHeaderDelegate(
        minHeight: 70,
        maxHeight: 70,
        child: Container(
          color: AppColors.backgroundColor,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your Tasks',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$activeTasks/${tasks.length} active',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTasksContent(
    BuildContext context,
    List<UgcTask> tasks,
    bool isEmptyState,
  ) {
    if (isEmptyState) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Illustration Image
              Center(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/images/empty_task.svg",
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "You don't have any current tasks here.\nWe will update you.",
                      style: AppTextStyles.defaultTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              /// -----------------------------
              /// Add Task Button -> switch tab
              /// -----------------------------
              ElevatedButton(
                onPressed: onAddTaskPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 20),
                    SizedBox(width: 8),
                    Text('Add Task', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(milliseconds: 300 + (index * 100)),
              child: _buildTaskCard(context, tasks[index]),
            ),
          );
        }, childCount: tasks.length),  // <-- Just tasks.length, not multiplied
      ),
    );


  }

  Widget _buildTaskCard(BuildContext context, UgcTask task) {
    // Calculate progress percentage
    final progress = task.totalSubtasks != null && task.totalSubtasks! > 0
        ? (task.completedSubtasks ?? 0) / task.totalSubtasks!
        : 0.0;

    final isSelfTask = task.assignedBy == null;
    final hasGroupMembers =
        task.groupMembers != null && task.groupMembers!.isNotEmpty;

    return Card(
      color: AppColors.backgroundColor,
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to task details
          // Get.to(() => UgcTaskDetailsScreen(task: task));
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.only(left: 16,bottom: 16,right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Status Badge (right aligned)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Status Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusBackgroundColor(task.status),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                    ),
                    child: Text(
                      _getStatusText(task.status),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getStatusTextColor(task.status),
                        fontFamily: 'Plus Jakarta Sans',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Task Title
              Text(
                task.title,
                style: AppTextStyles.smallHeading,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),

              // Time and Subtasks Row - FIXED VERSION
              Row(
                children: [
                  // Time
                  Icon(
                    Icons.access_time,
                    size: 14,
                    color: Colors.grey.shade600,
                  ),
                  Text(
                    task.time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Subtasks
                  if (task.totalSubtasks != null &&
                      task.totalSubtasks! > 0) ...[
                    Icon(
                      Icons.description_outlined,
                      size: 14,
                      color: Colors.grey.shade600,
                    ),
                    Text(
                      task.status == TaskStatus.inProgress
                          ? '${task.completedSubtasks ?? 0}/${task.totalSubtasks} subtasks'
                          : '${task.totalSubtasks} subtasks',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  const Spacer(),

                  // Progress Percentage (right aligned)
                  if (task.totalSubtasks != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 30,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: progress,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${(progress * 100).toInt()}% Completed',
                          style: AppTextStyles.smallText.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                ],
              ),

              const SizedBox(height: 16),

              DottedLine(),

              const SizedBox(height: 16),


              /// Bottom Section: Task Type and Actions
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Left side: Task type info (avatars + label or self task badge)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isSelfTask)
                        // Self Task badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: Colors.blue.shade200,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              'Self Task',
                              style: AppTextStyles.smallText.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          )
                        else if (hasGroupMembers)
                        // Group Task with avatars and label
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Group member avatars
                              SizedBox(
                                width: 80,
                                height: 35,
                                child: Stack(
                                  children: [
                                    for (int i = 0;
                                    i < (task.groupMembers!.length > 3
                                        ? 3
                                        : task.groupMembers!.length);
                                    i++)
                                      Positioned(
                                        left: i * 20.0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                          ),
                                          child: CircleAvatar(
                                            radius: 16,
                                            backgroundImage: AssetImage(
                                              task.groupMembers![i],
                                            ),
                                          ),
                                        ),
                                      ),
                                    // Show +X if more than 3 members
                                    if (task.groupMembers!.length > 3)
                                      Positioned(
                                        left: 60,
                                        child: Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey.shade300,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '+${task.groupMembers!.length - 3}',
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Group Task',
                                style: AppTextStyles.smallText.copyWith(
                                  color: AppColors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          )
                        else
                        // Regular assigned task (no group members)
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 16,
                                backgroundImage: AssetImage(
                                  "assets/images/dummy_user_image.png",
                                ),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  'Assigned by ${task.assignedBy ?? "Mr. Tom Alax"}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade700,
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),

                        // Show assigner info for group tasks (below avatars)
                        if (hasGroupMembers && task.assignedBy != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 14,
                                  backgroundImage: AssetImage(
                                    "assets/images/dummy_user_image.png",
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    'Assigned by ${task.assignedBy!}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),

                  /// Right side: Start Button
                  if (task.status == TaskStatus.pending)
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                        visualDensity: VisualDensity.compact,
                      ),
                      child: Text(
                        'Start',
                        style: AppTextStyles.smallText.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusBackgroundColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return Colors.grey.shade100;
      case TaskStatus.inProgress:
        return Colors.blue.shade50;
      case TaskStatus.completed:
        return Colors.green.shade50;
    }
  }

  Color _getStatusTextColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return Colors.grey.shade700;
      case TaskStatus.inProgress:
        return Colors.blue.shade700;
      case TaskStatus.completed:
        return Colors.green.shade700;
    }
  }

  String _getStatusText(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return 'Pending';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.completed:
        return 'Completed';
    }
  }

  List<UgcTask> _getTasks() {
    return [
      UgcTask(
        totalSubtasks: 5,
        completedSubtasks: 0,
        title: 'Complete Math Homework',
        description: 'Solve algebra, geometry and calculus problems.',
        time: '10.30 AM',
        status: TaskStatus.pending,
        createdAt: DateTime(2026, 1, 5, 9, 50),
        startTime: DateTime(2026, 1, 5, 10, 30),
        assignedBy: null,
        // Self task
        subtasks: [
          UgcSubTask(title: 'Algebra problems', isCompleted: false),
          UgcSubTask(title: 'Geometry exercises', isCompleted: false),
          UgcSubTask(title: 'Calculus problems', isCompleted: false),
        ],
      ),
      UgcTask(
        totalSubtasks: 5,
        completedSubtasks: 0,
        title: 'UX/UI Design',
        description: 'Design user interface mockups.',
        time: '10.30 AM',
        status: TaskStatus.pending,
        createdAt: DateTime(2026, 1, 5, 9, 50),
        startTime: DateTime(2026, 1, 5, 10, 30),
        assignedBy: 'Mr. Tom Alax',
      ),
      UgcTask(
        totalSubtasks: 3,
        completedSubtasks: 1,
        title: 'Complete Math Homework',
        description: 'Solve algebra, geometry and calculus problems.',
        time: '10.30 AM',
        status: TaskStatus.inProgress,
        createdAt: DateTime(2026, 1, 5, 9, 50),
        startTime: DateTime(2026, 1, 5, 10, 30),
        assignedBy: 'Mr. Tom Alax',
        groupMembers: [
          "assets/images/dummy_user_image.png",
          "assets/images/dummy_user_image.png",
          "assets/images/dummy_user_image.png",
        ],
        subtasks: [
          UgcSubTask(title: 'Algebra problems', isCompleted: true),
          UgcSubTask(title: 'Geometry exercises', isCompleted: true),
          UgcSubTask(title: 'Calculus problems', isCompleted: false),
        ],
      ),
      UgcTask(
        totalSubtasks: 4,
        completedSubtasks: 4,
        title: 'History Chapter Summary',
        description: 'Read chapter 5 and prepare summary notes.',
        time: '4:30 PM',
        status: TaskStatus.completed,
        createdAt: DateTime(2026, 1, 5, 9, 50),
        startTime: DateTime(2026, 1, 5, 16, 30),
        completedTime: DateTime(2026, 1, 5, 18, 0),
      ),
    ];
  }
}

/// Custom Sliver Persistent Header Delegate for pinned Tasks header
class _TasksHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _TasksHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_TasksHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
