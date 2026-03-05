import 'package:askfemi/features/individual_user/views/home/task_details/model/sub_task_model.dart';
import 'package:askfemi/features/individual_user/views/home/task_details/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_texts_style.dart';
import '../../widget/build_task_card.dart';
import '../notification/notification_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// Collapsible App Bar
          _buildSliverAppBar(),

          /// Daily Progress Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: _buildDailyProgress(),
            ),
          ),

          /// Pinned Tasks Header
          _buildPinnedTasksHeader(),

          /// Tasks List
          _buildTasksList(context),

          /// Bottom Padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 80,
      floating: false,
      pinned: true,
      stretch: true,
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16 ),
        background: Container(
          color: AppColors.backgroundColor,
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
                      style: AppTextStyles.smallText,
                    ),
                    Text(
                      'Rakibul',
                      style: AppTextStyles.defaultTextStyle.copyWith(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, bottom: 8),
              child: InkWell(
                onTap: ()=> Get.to(()=>NotificationScreen(),transition: Transition.fadeIn),
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

  Widget _buildDailyProgress() {
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
                    '1 / 3',
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
                    value: 1 / 3,
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
              '3 tasks remaining. You\'ve got this!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontFamily: 'Plus Jakarta Sans',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinnedTasksHeader() {
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
              Chip(
                label: Text(
                  '1 / 3 active',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 12,
                    fontFamily: 'Plus Jakarta Sans',
                  ),
                ),
                backgroundColor: AppColors.lightGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                side: const BorderSide(width: 0, color: Colors.transparent),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTasksList(BuildContext context) {
    final tasks = _getTasks();

    // If no tasks, show empty state
    if (tasks.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/empty_task.svg',
                height: 200,
              ),
              const SizedBox(height: 24),
              Text(
                'No tasks yet',
                style: AppTextStyles.defaultTextStyle.copyWith(
                  fontSize: 30
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Create your task to get started!',
                style: AppTextStyles.defaultTextStyle,
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {


            final taskIndex = index ~/ 2;
            return Column(
              children: [
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: Duration(milliseconds: 300 + (taskIndex * 100)),
                  child: buildTaskCard(
                    context: context,
                    task: tasks[taskIndex],
                  ),
                ),
                SizedBox(height: 16,)
              ],
            );
          },
          childCount: tasks.length * 2 - 1,
        ),
      ),
    );
  }

  List<Task> _getTasks() {
    return [
      Task(
        title: 'Complete Math Homework',
        description: 'Solve algebra, geometry and calculus problems.',
        time: '10:30 AM',
        status: TaskStatus.pending,
        createdAt: DateTime(2026, 1, 5, 9, 50),
        startTime: DateTime(2026, 1, 5, 10, 30),
      ),
      Task(
        totalSubtasks: 6,
        completedSubtasks: 2,
        title: 'Complete Math Homework',
        description: 'Solve algebra, geometry and calculus problems.',
        time: '10:30 AM',
        status: TaskStatus.inProgress,
        createdAt: DateTime(2026, 1, 5, 9, 50),
        startTime: DateTime(2026, 1, 5, 10, 30),
      ),
      Task(
        totalSubtasks: 3,
        completedSubtasks: 2,
        title: 'Complete Math Homework',
        description: 'Solve algebra, geometry and calculus problems.',
        time: '10:30 AM',
        status: TaskStatus.inProgress,
        createdAt: DateTime(2025, 1, 5, 9, 50),
        startTime: DateTime(2026, 1, 5, 10, 30),
        subtasks: [
          SubTask(
            title: 'Call with team',
            isCompleted: false,
            duration: null,
          ),
          SubTask(
            title: 'Client meeting',
            isCompleted: true,
            duration: '10 min',
          ),
          SubTask(
            title: 'Team discuss',
            isCompleted: true,
            duration: '20 min',
          ),
        ],
      ),
      Task(
        title: 'Complete Math Homework',
        description: 'Solve algebra, geometry and calculus problems.',
        time: '10:30 AM',
        status: TaskStatus.completed,
        createdAt: DateTime(2024, 1, 5, 9, 50),
        startTime: DateTime(2024, 1, 5, 10, 30),
        completedTime: DateTime(2024, 1, 7, 10, 50),
      ),
      Task(
        totalSubtasks: 5,
        completedSubtasks: 5,
        title: 'Complete Math Homework',
        description: 'Solve algebra, geometry and calculus problems.',
        time: '10:30 AM',
        status: TaskStatus.completed,
        createdAt: DateTime(2026, 1, 5, 9, 50),
        startTime: DateTime(2026, 1, 5, 10, 30),
        completedTime: DateTime(2026, 1, 7, 10, 50),
        subtasks: [
          SubTask(
            title: 'Call with team',
            isCompleted: true,
            duration: null,
          ),
          SubTask(
            title: 'Client meeting',
            isCompleted: true,
            duration: '10 min',
          ),
          SubTask(
            title: 'Team discuss',
            isCompleted: true,
            duration: '20 min',
          ),
        ],
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