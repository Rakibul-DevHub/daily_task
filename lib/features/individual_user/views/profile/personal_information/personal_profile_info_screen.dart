import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_texts_style.dart';
import '../../../widget/edit_update_button.dart';
import 'edit_personal_profile_info_screen.dart';

/// ===============================================================
/// PERSONAL INFORMATION SCREEN (VIEW MODE)
/// ===============================================================
class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.transparent,
        elevation: 0,
        title: Text('Personal Information', style: AppTextStyles.largeHeading),
      ),
      body: Column(
        children: [
          /// -------------------------------
          /// SCROLLABLE CONTENT
          /// -------------------------------
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 16),
              child: Card(
                color: AppColors.backgroundColor,
                margin: const EdgeInsets.all(16),
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      ProfileAvatar(),
                      SizedBox(height: 30),

                      InfoRow(label: 'Name', value: 'Rakibul'),
                      InfoRow(label: 'Email', value: 'r@gmail.com'),
                      InfoRow(label: 'Phone number', value: '14164161631'),
                      InfoRow(label: 'Address', value: 'USA'),
                      InfoRow(label: 'Gender', value: 'Male'),
                      InfoRow(label: 'Date of Birth', value: '1.1.2025'),
                      InfoRow(label: 'Age', value: '12'),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// -------------------------------
          /// FIXED BOTTOM BUTTON
          /// -------------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
            child: EditUpdateButton(
              title: 'Edit Profile',
              onPressed: () {
                Get.to(()=>EditPersonalProfileInfoScreen());
              },
            ),
          ),
        ],
      ),
    );
  }
}



/// ===============================================================
/// REUSABLE WIDGETS
/// ===============================================================

/// ----------------------------
/// INFO ROW (VIEW MODE)
/// ----------------------------
class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.smallText.copyWith(color: AppColors.black),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.defaultTextStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(height: 24),
      ],
    );
  }
}

/// ----------------------------
/// LABELED TEXT FIELD (EDIT MODE)
/// ----------------------------
class LabeledTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.black.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.smallText.copyWith(
              color: AppColors.black.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            style: AppTextStyles.defaultTextStyle.copyWith(
              fontWeight: FontWeight.w600,
            ),
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}


