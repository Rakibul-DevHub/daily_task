import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_texts_style.dart';
import '../../../../utils/static_text.dart';
import 'about_us_privacy_policy_terms_condition.dart';
import 'change_password_screen.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'contact_us_screen.dart';





/// -----------------------------
/// ====== SETTINGS SCREEN ======
/// -----------------------------
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.iconColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Settings', style: AppTextStyles.smallHeading),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: AppColors.cardBackgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(color: AppColors.lightGrey, width: 1.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildListItem(
                icon: const Icon(Icons.key, size: 24, color: AppColors.iconColor),
                title: 'Change Password',
                trailing: const Icon(Icons.chevron_right, size: 20, color: AppColors.iconColor),
                onTap: () =>  Get.to(()=>ChangePasswordScreen()),
              ),
              Divider(height: 1, indent: 16, endIndent: 16, color: AppColors.grey),
              _buildListItem(
                icon: const Icon(Icons.warning_amber_outlined, size: 24, color: AppColors.iconColor),
                title: 'Privacy policy',
                trailing: const Icon(Icons.chevron_right, size: 20, color: AppColors.iconColor),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutUsPrivacyPolicyTermsConditionScreen(pageTitle: 'Privacy Policy',content: StaticText.privacyPolicy,))),
              ),
              Divider(height: 1, indent: 16, endIndent: 16, color: AppColors.grey),
              _buildListItem(
                icon: const Icon(Icons.bookmark_outline, size: 24, color: AppColors.iconColor),
                title: 'Terms & conditions',
                trailing: const Icon(Icons.chevron_right, size: 20, color: AppColors.iconColor),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutUsPrivacyPolicyTermsConditionScreen(pageTitle: 'Terms & Conditions',content: StaticText.termsAndConditions,))),
              ),
              Divider(height: 1, indent: 16, endIndent: 16, color: AppColors.grey),
              _buildListItem(
                icon: const Icon(Icons.info_outline, size: 24, color: AppColors.iconColor),
                title: 'About us',
                trailing: const Icon(Icons.chevron_right, size: 20, color: AppColors.iconColor),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutUsPrivacyPolicyTermsConditionScreen(pageTitle: 'About Us',content: StaticText.aboutUs,))),
              ),
              Divider(height: 1, indent: 16, endIndent: 16, color: AppColors.grey),
              _buildListItem(
                icon: const Icon(Icons.headset_mic, size: 24, color: AppColors.iconColor),
                title: 'Contact us',
                trailing: const Icon(Icons.chevron_right, size: 20, color: AppColors.iconColor),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactUsScreen())),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListItem({
    required Widget icon,
    required String title,
    required Widget trailing,
    required VoidCallback onTap, // 👈 Added this
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      leading: icon,
      title: Text(title, style: AppTextStyles.defaultTextStyle.copyWith(
        fontSize: 12,
        height: 1,

      )),
      trailing: trailing,
      onTap: onTap, // 👈 Now uses passed callback
    );
  }
}