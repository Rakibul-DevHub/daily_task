import 'package:askfemi/features/group_user/visions/ugc_add_task/ugc_personal_task_screen.dart';
import 'package:askfemi/features/group_user/visions/ugc_add_task/ugc_single_or_collaborative_task_screen.dart';
import 'package:askfemi/utils/app_colors.dart';
import 'package:askfemi/utils/app_texts_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class UgcAddTaskScreen extends StatelessWidget {
  const UgcAddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.transparent,
        elevation: 0,
        title: Text(
          'Create Task',
          style: AppTextStyles.largeHeading.copyWith(
            color: AppColors.primaryColor,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: [
          Text(
            'Track and analyze task performance across your team',
            textAlign: TextAlign.center,
            style: AppTextStyles.smallText.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 24),
          // Single Assignment - Filled Button with centered "or"
          CreateTaskCard(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Collaborative Task',
                  textAlign: TextAlign.left,
                  style: AppTextStyles.smallHeading.copyWith(fontSize: 18),
                ),
                Text(
                  '  or  ',
                  textAlign: TextAlign.left,
                  style: AppTextStyles.smallHeading.copyWith(fontSize: 18),
                ),
                Text(
                  'Single Assignment',
                  textAlign: TextAlign.left,
                  style: AppTextStyles.smallHeading.copyWith(fontSize: 18),
                ),
              ],
            ),
            subtitle: 'Assign task to one or multiple members',
            buttonText: 'Create Task',
            svgIcon: SvgPicture.asset(
              'assets/icons/collaborative_task_icon.svg',
            ),
            iconBackgroundColor: AppColors.primaryColor,
            isOutlined: false,
          ),
          const SizedBox(height: 16),
          // Personal Task - Keep as simple string
          CreateTaskCard(
            title: 'Personal Task',
            subtitle: 'Create task for yourself',
            buttonText: 'Create Task',
            iconBackgroundColor: Colors.blue.shade50,
            svgIcon: SvgPicture.asset('assets/icons/personal_task.svg'),
            isOutlined: true,
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}

class CreateTaskCard extends StatelessWidget {
  // title can be String or Widget
  final dynamic title;
  final String subtitle;
  final String buttonText;
  final Color iconBackgroundColor;
  final bool isOutlined;

  // Icon-related properties
  final IconData? iconData;
  final SvgPicture? svgIcon;
  final String? svgAssetPath;
  final double iconSize;
  final Color? iconColor;

  const CreateTaskCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.iconBackgroundColor,
    this.isOutlined = false,
    this.iconData,
    this.svgIcon,
    this.svgAssetPath,
    this.iconSize = 35,
    this.iconColor,
  }) : assert(
  (iconData != null && svgIcon == null && svgAssetPath == null) ||
      (iconData == null && svgIcon != null && svgAssetPath == null) ||
      (iconData == null && svgIcon == null && svgAssetPath != null),
  'Provide either iconData, svgIcon, or svgAssetPath, but not multiple',
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightBlueColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon container
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(child: svgIcon),
            ),
            const SizedBox(height: 16),

            // Title and subtitle
            if (title is String)
              Text(
                title,
                style: AppTextStyles.smallHeading.copyWith(fontSize: 18),
              )
            else if (title is Widget)
              title as Widget,
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: AppTextStyles.smallText.copyWith(fontSize: 14),
            ),

            const SizedBox(height: 20),

            // Button
            SizedBox(
              width: double.infinity,
              child: isOutlined
                  ? OutlinedButton(
                onPressed: () {
                  Get.to(() => const UgcPersonalTaskScreen());
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side: BorderSide(color: AppColors.primaryColor),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  buttonText,
                  style: AppTextStyles.smallHeading.copyWith(
                    fontSize: 16,
                  ),
                ),
              )
                  : ElevatedButton(
                onPressed: () {
                  Get.to(() => const UgcSingleOrCollaborativeTaskScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  buttonText,
                  style: AppTextStyles.smallHeading.copyWith(
                    fontSize: 16,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
