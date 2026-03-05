import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_texts_style.dart';
import '../bottom_navigation/main_bottom_nav.dart';

class ChooseSupportModeScreen extends StatefulWidget {
  final bool fromProfile;

  const ChooseSupportModeScreen({
    super.key,
    this.fromProfile = false,
  });

  @override
  State<ChooseSupportModeScreen> createState() =>
      _ChooseSupportModeScreenState();
}

class _ChooseSupportModeScreenState extends State<ChooseSupportModeScreen> {
  String? selectedMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.transparent,
        elevation: 0,
        title: widget.fromProfile ?
         Text("Support Mode",style: AppTextStyles.largeHeading,) : null,
        leading: widget.fromProfile ? IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ) : null,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            if (!widget.fromProfile) const SizedBox(height: 60),

            // Title
            if (!widget.fromProfile)
            const Text(
              'Choose Your Support Style',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Plus Jakarta Sans',
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Subtitle
            if (!widget.fromProfile)
            Text(
              'How would you like Clarity to communicate with you?',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.grey,
                fontFamily: 'Plus Jakarta Sans',
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            // Support Style Cards
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildSupportCard(
                      mode: 'calm',
                      icon:
                      SvgPicture.asset(
                        'assets/images/clam.svg',
                        width: 35,
                        height: 35,
                      ),
                      title: 'Calm',
                      description:
                      'Gentle guidance with peaceful reminders and soothing encouragement.',
                      quote: '"Take your time. Each small step matters."',
                      isSelected: selectedMode == 'calm',
                    ),


                    const SizedBox(height: 16),
                    _buildSupportCard(
                      mode: 'encouraging',
                      icon: SvgPicture.asset(
                        'assets/images/encouraging.svg',
                        width: 35,
                        height: 35,
                      ),
                      title: 'Encouraging',
                      description:
                      'Positive energy with motivational reminders and uplifting support.',
                      quote: '"You\'re doing great! Keep up the momentum!"',
                      isSelected: selectedMode == 'encouraging',
                    ),
                    const SizedBox(height: 16),
                    _buildSupportCard(
                      mode: 'logical',
                      icon: SvgPicture.asset(
                        'assets/images/logical.svg',
                        width: 35,
                        height: 35,
                      ),
                      title: 'Logical',
                      description:
                      'Gentle guidance with peaceful reminders and soothing encouragement.',
                      quote: null,
                      isSelected: selectedMode == 'logical',
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Button based on navigation source
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: selectedMode != null
                    ? () {
                  debugPrint('Selected mode: $selectedMode');

                  if (widget.fromProfile) {
                    // If coming from profile, just go back
                    Navigator.pop(context);
                    // You might want to save the preference here
                  } else {
                    // If coming from initial setup, go to main app
                    Get.offAll(const MainBottomNav());
                  }
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  disabledBackgroundColor: AppColors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  widget.fromProfile ? 'Save Changes' : 'Get Started',
                  style: AppTextStyles.smallHeading.copyWith(
                    color: selectedMode != null ? AppColors.white : AppColors.lightGrey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

/*  Widget _buildSupportCard({
    required String mode,
    required String emoji,
    required String title,
    required String description,
    String? quote,
    required bool isSelected,
  })*/

  Widget _buildSupportCard({
    required String mode,
    required Widget icon,
    required String title,
    required String description,
    String? quote,
    required bool isSelected,
  })

  {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMode = mode;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.selectionFillColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emoji and Title Row
            Row(
              children: [
                // Emoji Circle
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _getEmojiBackgroundColor(mode),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    // child: Text(
                    //   emoji,
                    //   style: const TextStyle(fontSize: 24),
                    // ),
                    child: Center(child: icon),
                  ),
                ),
                const SizedBox(width: 12),
                // Title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Plus Jakarta Sans',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              description,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
                height: 1.5,
                fontFamily: 'Plus Jakarta Sans',
              ),
            ),

            // Quote (if available)
            if (quote != null) ...[
              const SizedBox(height: 12),
              Text(
                quote,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                  fontFamily: 'Plus Jakarta Sans',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getEmojiBackgroundColor(String mode) {
    switch (mode) {
      case 'calm':
        return  AppColors.calmColor;
      case 'encouraging':
        return AppColors.encouragingColor;
      case 'logical':
        return AppColors.logicalColor;
      default:
        return AppColors.grey;
    }
  }
}