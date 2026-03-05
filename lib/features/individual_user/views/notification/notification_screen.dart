
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_texts_style.dart';
import '../../../../utils/static_text.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _showNotifications = false;
  final List<Map<String, dynamic>> _dummyNotifications = [
    {
      'title': 'Task Completed',
      'message': 'Your project meeting task has been completed',
      'time': DateTime.now().subtract(const Duration(minutes: 30)),
      'read': false,
    },
    {
      'title': 'Task Reminder',
      'message': 'Submit weekly report in 2 hours',
      'time': DateTime.now().subtract(const Duration(hours: 2)),
      'read': false,
    },
    {
      'title': 'New Task Assigned',
      'message': 'You have been assigned a new task: Client Presentation',
      'time': DateTime.now().subtract(const Duration(hours: 5)),
      'read': true,
    },
    {
      'title': 'Task Deadline',
      'message': 'Budget planning task deadline is tomorrow',
      'time': DateTime.now().subtract(const Duration(days: 1)),
      'read': true,
    },
    {
      'title': 'Team Update',
      'message': 'John updated the history of team task',
      'time': DateTime.now().subtract(const Duration(days: 2)),
      'read': true,
    },
  ];

  void _toggleNotifications() {
    setState(() {
      _showNotifications = !_showNotifications;
    });
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('dd MMM').format(time);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: AppTextStyles.smallHeading,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Dummy Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _toggleNotifications,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                _showNotifications ? 'Hide Notifications' : 'Show Dummy Notifications',
                style: AppTextStyles.defaultTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Content
          Expanded(
            child: _showNotifications
                ? _buildNotificationList()
                : _buildEmptyState(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/empty_notificaiton_screen_iconWithText.svg",
            width: double.infinity,
            height: 300,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _dummyNotifications.length,
      itemBuilder: (context, index) {
        final notification = _dummyNotifications[index];
        final isUnread = !notification['read'];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Notification Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getNotificationIcon(notification['title']),
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),

                // Notification Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification['title'],
                              style: AppTextStyles.defaultTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          if (isUnread)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification['message'],
                        style: AppTextStyles.smallText.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _formatTime(notification['time']),
                        style: AppTextStyles.smallText.copyWith(
                          color: AppColors.lightGrey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _getNotificationIcon(String title) {
    if (title.contains('Completed')) {
      return Icons.check_circle;
    } else if (title.contains('Reminder')) {
      return Icons.access_time;
    } else if (title.contains('Assigned')) {
      return Icons.assignment;
    } else if (title.contains('Deadline')) {
      return Icons.warning;
    } else {
      return Icons.group;
    }
  }
}