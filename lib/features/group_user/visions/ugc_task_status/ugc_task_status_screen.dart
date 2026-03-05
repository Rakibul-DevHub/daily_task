import 'package:askfemi/utils/app_colors.dart';
import 'package:askfemi/utils/app_texts_style.dart';
import 'package:flutter/material.dart';
import 'package:avatar_stack/avatar_stack.dart';

class UgcTaskStatusScreen extends StatefulWidget {
  const UgcTaskStatusScreen({super.key});

  @override
  State<UgcTaskStatusScreen> createState() => _UgcTaskStatusScreenState();
}

class _UgcTaskStatusScreenState extends State<UgcTaskStatusScreen> {
  int selectedTab = 0;
  final List<String> tabTitles = ['Pending', 'In Progress', 'Completed'];

  final List<List<Map<String, dynamic>>> taskData = [
    [
      {
        'title': 'Complete Math Home work',
        'time': '10.30 AM',
        'subtasks': null,
        'progress': null,
        'assignee': 'Assigned by Mr Tom Alex',
        'taskType': null,
        'isGroupTask': false,
      },
      {
        'title': 'UI/UX design',
        'time': '10.30 AM',
        'subtasks': 5,
        'progress': 0,
        'assignee': 'Assigned by Mr Tom Alex',
        'taskType': 'Self Task',
        'isGroupTask': false,
      },
      {
        'title': 'Math Home work',
        'time': '10.30 AM',
        'subtasks': 5,
        'progress': 0,
        'assignee': 'Assigned by Mr Tom Alex',
        'taskType': null,
        'isGroupTask': false,
      },
      {
        'title': 'Landing page design',
        'time': '10.30 AM',
        'subtasks': 5,
        'progress': 0,
        'assignee': 'Assigned by Mr Tom Alex',
        'taskType': 'Group Tasks',
        'isGroupTask': true,
      },
    ],
    [
      {
        'title': 'Mobile App Development',
        'time': '02.00 PM',
        'subtasks': 8,
        'progress': 60,
        'assignee': 'Assigned by John Doe',
        'taskType': 'Self Task',
        'isGroupTask': false,
      },
      {
        'title': 'Backend API Integration',
        'time': '11.00 AM',
        'subtasks': 3,
        'progress': 40,
        'assignee': 'Assigned by Jane Smith',
        'taskType': null,
        'isGroupTask': false,
      },
      {
        'title': 'Team Project Review',
        'time': '03.30 PM',
        'subtasks': 6,
        'progress': 75,
        'assignee': 'Assigned by Team Lead',
        'taskType': 'Group Tasks',
        'isGroupTask': true,
      },
    ],
    [
      {
        'title': 'Research Paper Writing',
        'time': '09.00 AM',
        'subtasks': 4,
        'progress': 100,
        'assignee': 'Assigned by Dr. Williams',
        'taskType': 'Self Task',
        'isGroupTask': false,
      },
      {
        'title': 'Database Migration',
        'time': '01.00 PM',
        'subtasks': 7,
        'progress': 100,
        'assignee': 'Assigned by Tech Lead',
        'taskType': null,
        'isGroupTask': false,
      },
      {
        'title': 'Marketing Campaign',
        'time': '04.00 PM',
        'subtasks': 10,
        'progress': 100,
        'assignee': 'Assigned by Marketing Head',
        'taskType': 'Group Tasks',
        'isGroupTask': true,
      },
      {
        'title': 'Client Presentation',
        'time': '11.30 AM',
        'subtasks': 5,
        'progress': 100,
        'assignee': 'Assigned by Sales Manager',
        'taskType': 'Self Task',
        'isGroupTask': false,
      },
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'All Status',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildStatusTab('Pending (${taskData[0].length})', 0),
                    const SizedBox(width: 8),
                    _buildStatusTab('In Progress (${taskData[1].length})', 1),
                    const SizedBox(width: 8),
                    _buildStatusTab('Completed (${taskData[2].length})', 2),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final task = taskData[selectedTab][index];
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: 12,
                            left: 16,
                            right: 16,
                            top: index == 0 ? 0 : 0,
                          ),
                          child: _buildTaskCard(
                            title: task['title'] as String,
                            time: task['time'] as String,
                            subtasks: task['subtasks'] as int?,
                            progress: task['progress'] as int?,
                            assignee: task['assignee'] as String?,
                            taskType: task['taskType'] as String?,
                            isGroupTask: task['isGroupTask'] as bool,
                            status: selectedTab,
                          ),
                        );
                      },
                      childCount: taskData[selectedTab].length,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTab(String text, int index) {
    final isSelected = selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4A90E2) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF4A90E2) : Colors.grey.shade300,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade600,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildTaskCard({
    required String title,
    required String time,
    int? subtasks,
    int? progress,
    String? assignee,
    String? taskType,
    required bool isGroupTask,
    required int status,
  }) {
    String buttonText = 'Start';
    Color buttonColor = AppColors.primaryColor;
    bool showButton = true;

    switch (status) {
      case 0:
        buttonText = 'Start';
        buttonColor = AppColors.primaryColor;
        break;
      case 1:
        buttonText = 'Completed';
        buttonColor = AppColors.primaryColor;
        break;
      case 2:
        showButton = false;
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                if (subtasks != null) ...[
                  Row(
                    children: [
                      Icon(Icons.list_alt, size: 16, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        '$subtasks subtasks',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Spacer(),
                  if (progress != null)
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: FractionallySizedBox(
                            widthFactor: progress / 100,
                            alignment: Alignment.centerLeft,
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
                          '$progress%',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                ],
              ],
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: _buildBottomSection(
                    taskType: taskType,
                    assignee: assignee,
                    isGroupTask: isGroupTask,
                  ),
                ),
                const SizedBox(width: 8),
                if (showButton)
                  ElevatedButton(
                    onPressed: () {
                      if (status == 0) {
                        print('Starting task: $title');
                      } else if (status == 1) {
                        print('Completing task: $title');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Text(
                        buttonText,
                        style: AppTextStyles.smallText.copyWith(
                          color: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection({
    String? taskType,
    String? assignee,
    required bool isGroupTask,
  }) {
    if (taskType != null && !isGroupTask) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.lightBlueColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          taskType,
          style: const TextStyle(fontSize: 12, color: Color(0xFF4A90E2)),
        ),
      );
    } else if (assignee != null && !isGroupTask) {
      return Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey.shade300,
            child: Icon(Icons.person, size: 16, color: Colors.grey.shade600),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              assignee,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    } else if (isGroupTask) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // ✅ FIXED: Correct avatar_stack v3.0.0 API
              SizedBox(
                width: 80,
                height: 32,
                child: AvatarStack(
                  height: 32,
                  avatars: const [
                    ExactAssetImage("assets/images/dummy_child_user_image.png"),
                    ExactAssetImage("assets/images/dummy_child_user_image.png"),
                    ExactAssetImage("assets/images/dummy_child_user_image.png"),
                    ExactAssetImage("assets/images/dummy_child_user_image.png"),
                    ExactAssetImage("assets/images/dummy_child_user_image.png"),
                  ],
                  borderWidth: 2,
                  borderColor: Colors.white,
                  // ✅ FIXED: InfoWidgetBuilder signature is (hiddenCount, totalAvatars)
                  infoWidgetBuilder: (hiddenCount, totalAvatars) {
                    return Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '+$hiddenCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          if (taskType != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.lightBlueColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                taskType,
                style: const TextStyle(fontSize: 12, color: Color(0xFF4A90E2)),
              ),
            ),
          const SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey.shade300,
                child: Icon(
                  Icons.person,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  assignee ?? '',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      );
    }
    return const SizedBox();
  }
}