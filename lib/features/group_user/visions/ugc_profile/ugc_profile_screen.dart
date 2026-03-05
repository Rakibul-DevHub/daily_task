import 'package:askfemi/auth/sign_in/singn_in_screen.dart';
import 'package:askfemi/features/individual_user/views/notification/notification_style_screen.dart';
import 'package:askfemi/features/individual_user/views/profile/personal_information/personal_profile_info_screen.dart';
import 'package:askfemi/features/individual_user/views/subscription/subscription_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../../screens/settings/settings_screen.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_texts_style.dart';
import '../../../individual_user/views/choose_support_mode/choose_support_mode_screen.dart';

class UgcProfileScreen extends StatelessWidget {
  const UgcProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Profile Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightGrey),
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Profile Image
                      Stack(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                image: AssetImage(
                                  "assets/images/dummy_user_image.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Crown Icon
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.amber,
                              ),
                              child: SvgPicture.asset(
                                  "assets/images/task_manager_permission.svg"),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      // Name and Email
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Rakibul', style: AppTextStyles.largeHeading),
                          const SizedBox(height: 4),
                          Text(
                            'R@gmail.com',
                            style: AppTextStyles.smallText.copyWith(
                                color: AppColors.black, fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColors.batchColor,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              'Task Manager',
                              style: AppTextStyles.smallText.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Preferred Time Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightGrey),
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.access_time,
                              color: AppColors.backgroundColor,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Preferred time',
                                style: AppTextStyles.smallHeading,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'When you usually work on tasks',
                                style: AppTextStyles.smallText,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Time Picker Field
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          border: Border.all(color: AppColors.grey, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              '07 : 00 AM',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF1A1A1A),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.access_time_outlined,
                              color: Color(0xFF999999),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Menu Items Card
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightGrey),
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Personal Information
                      _buildMenuItem(
                        icon: CupertinoIcons.person_crop_circle,
                        iconColor: AppColors.iconColor,
                        title: 'Personal information',
                        onTap: () {
                          Get.to(() => const PersonalInformationScreen());
                        },
                      ),
                      _buildDivider(),
                      ///----------------
                      /// Support Mode
                      /// ---------------
                      _buildMenuItem(
                        icon: Icons.lightbulb_outline,
                        iconColor: AppColors.iconColor,
                        title: 'Support Mode',
                        onTap: () {
                          Get.to(() => const ChooseSupportModeScreen(
                              fromProfile: true));
                        },
                      ),
                      _buildDivider(),
                      // Notification Style
                      _buildMenuItem(
                        icon: Icons.notifications_outlined,
                        iconColor: AppColors.iconColor,
                        title: 'Notification Style',
                        onTap: () {
                          Get.to(() => const NotificationStyleScreen());
                        },
                      ),
                      _buildDivider(),
                      // Setting
                      _buildMenuItem(
                        icon: Icons.settings_outlined,
                        iconColor: AppColors.iconColor,
                        title: 'Settings',
                        onTap: () {
                          Get.to(() => const SettingsScreen());
                        },
                      ),
                      _buildDivider(),
                      // Logout
                      _buildMenuItem(
                        icon: Icons.logout,
                        iconColor: AppColors.iconColor,
                        title: 'Logout',
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirm Logout"),
                                content: const Text(
                                    "Are you sure you want to logout?"),
                                backgroundColor: AppColors.backgroundColor,
                                icon: const Icon(Icons.logout_outlined,
                                    color: Colors.red),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                actions: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                        AppColors.primaryColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(8)) // Logout button color
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: AppTextStyles.defaultTextStyle
                                          .copyWith(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                        AppColors.liteRedColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(8)) // Logout button color
                                    ),
                                    onPressed: () {
                                      Get.offAll(() =>  SignInScreen());
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Logged out successfully")),
                                      );
                                    },
                                    child: Text(
                                      "Logout",
                                      style: AppTextStyles.defaultTextStyle
                                          .copyWith(
                                          color: AppColors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        isLast: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Subscription Card (if needed - uncomment to use)
                // buildSubscriptionCard(fromProfile: true),
                // const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    bool hasTag = false,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: subtitle != null ? 16 : 18,
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                      if (hasTag) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF4CAF50),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'active',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF999999),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            const Icon(
              Icons.arrow_forward,
              color: Color(0xFFCCCCCC),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.only(left: 60),
      height: 1,
      color: AppColors.grey.withValues(alpha: 0.3),
    );
  }

  Widget buildSubscriptionCard({required bool fromProfile}) {
    return InkWell(
      onTap: () {
        // Pass the fromProfile flag to the SubscriptionPage
        Get.to(() => SubscriptionPage(
          fromProfile: true,
        ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.lightGrey, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Diamond Icon
            const Icon(Icons.diamond_outlined, color: Color(0xFFFFB74D), size: 30),
            const SizedBox(width: 12),
            // Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Subscription Package Individual',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Renewal date: 10/06/25',
                        style: TextStyle(
                            fontSize: 12, color: Color(0xFF8E8E8E)),
                      ),
                      // Active Tag
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Active',
                          style: AppTextStyles.smallText
                              .copyWith(color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}