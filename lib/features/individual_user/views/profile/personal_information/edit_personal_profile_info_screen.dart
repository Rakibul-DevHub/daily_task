
/// ===============================================================
/// EDIT PROFILE SCREEN
/// ===============================================================
library;

import 'package:askfemi/features/individual_user/views/profile/personal_information/personal_profile_info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_texts_style.dart';
import '../../../widget/edit_update_button.dart';



class EditPersonalProfileInfoScreen extends StatefulWidget {
  const EditPersonalProfileInfoScreen({super.key});

  @override
  State<EditPersonalProfileInfoScreen> createState() => _EditPersonalProfileInfoScreenState();
}

class _EditPersonalProfileInfoScreenState extends State<EditPersonalProfileInfoScreen> {
  /// Controllers for all editable fields
  final nameController = TextEditingController(text: 'Rakibul');
  final emailController = TextEditingController(text: 'r@gmail.com');
  final phoneController = TextEditingController(text: '14164161631');
  final addressController = TextEditingController(text: 'USA');
  final genderController = TextEditingController(text: 'Male');
  final dobController = TextEditingController(text: '1.1.2025');
  final ageController = TextEditingController(text: '12');

  @override
  void dispose() {
    /// Always dispose controllers
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    genderController.dispose();
    dobController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        surfaceTintColor: AppColors.transparent,
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text('Edit Profile', style: AppTextStyles.largeHeading),
      ),
      body: Column(
        children: [
          /// Scrollable form
          Expanded(
            child: SingleChildScrollView(
              child: Card(
                color: AppColors.backgroundColor,
                margin: const EdgeInsets.all(16),
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      /// Profile avatar with edit icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [const ProfileAvatar(showEdit: true)],
                      ),
                      const SizedBox(height: 30),

                      /// Editable fields
                      LabeledTextField(
                        label: 'Name',
                        controller: nameController,
                      ),
                      const SizedBox(height: 16),

                      LabeledTextField(
                        label: 'Email',
                        controller: emailController,
                      ),
                      const SizedBox(height: 16),

                      LabeledTextField(
                        label: 'Phone number',
                        controller: phoneController,
                      ),
                      const SizedBox(height: 16),

                      LabeledTextField(
                        label: 'Address',
                        controller: addressController,
                      ),
                      const SizedBox(height: 16),

                      LabeledTextField(
                        label: 'Gender',
                        controller: genderController,
                      ),
                      const SizedBox(height: 16),

                      LabeledTextField(
                        label: 'Date of Birth',
                        controller: dobController,
                      ),
                      const SizedBox(height: 16),

                      LabeledTextField(label: 'Age', controller: ageController),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// Update button
          Padding(
            padding: const EdgeInsets.all(16),
            child: EditUpdateButton(
              title: 'Update Profile',
              onPressed: () {
                /// Handle update logic here
                Get.back();
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}



/// ----------------------------
/// PROFILE AVATAR WIDGET
/// ----------------------------
class ProfileAvatar extends StatelessWidget {
  final bool showEdit;

  const ProfileAvatar({super.key, this.showEdit = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CircleAvatar(
          radius: 60,
          foregroundImage: AssetImage('assets/images/dummy_user_image.png'),
        ),

        /// Edit icon shown only in edit screen
        if (showEdit)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(CupertinoIcons.pencil_circle_fill, size: 25, color: Colors.white),
            ),
          ),
      ],
    );
  }
}