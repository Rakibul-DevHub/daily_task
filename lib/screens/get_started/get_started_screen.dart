import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../screens/onboarding/onboarding_screen.dart';
import '../../utils/app_colors.dart';
import 'package:askfemi/utils/app_texts_style.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// Image
          Flexible(
            child: SizedBox(
              width: double.infinity,
              child: Image.asset(
                "assets/images/get_started.png",
                fit: BoxFit.cover,
                cacheWidth: 1080,
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.03),

          /// Welcome Text (same alignment & structure)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: _WelcomeText(),
              ),
            ],
          ),

          SizedBox(height: screenHeight * 0.03),

          /// Description
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: _DescriptionText(),
          ),

          SizedBox(height: screenHeight * 0.03),

          /// Button
          SizedBox(
            width: double.infinity,
            height: screenHeight * 0.09,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                onPressed: () => Get.to(() => const OnboardingScreen()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Continue",
                  style: AppTextStyles.smallText.copyWith(
                    fontSize: 18,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Same UI, just removed unnecessary Column wrapper
class _WelcomeText extends StatelessWidget {
  const _WelcomeText();

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: AppTextStyles.defaultTextStyle.copyWith(
          fontSize: 60,
          fontWeight: FontWeight.bold,
          height: 1,
        ),
        children: [
          TextSpan(
            text: "Welcome\nto ",
            style: TextStyle(color: AppColors.black),
          ),
          TextSpan(
            text: "Z",
            style: TextStyle(color: AppColors.primaryColor),
          ),
          TextSpan(
            text: "3",
            style: TextStyle(color: AppColors.primaryColor,fontSize: 45,fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: "ns!",
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}

class _DescriptionText extends StatelessWidget {
  const _DescriptionText();

  @override
  Widget build(BuildContext context) {
    return Text(
      "A mindful space for your daily tasks. We believe in doing less, but better.",
      style: AppTextStyles.defaultTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.black,
        height: 1,
      ),
    );
  }
}
