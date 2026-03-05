import 'package:flutter/material.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_texts_style.dart';
import '../../../../utils/static_text.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.iconColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Contact Us', style: AppTextStyles.smallHeading),
        centerTitle: false,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primaryColor, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.primaryColor,
                      child: const Icon(Icons.email_outlined, color: AppColors.white),
                    ),
                    const SizedBox(height: 8), // vertical spacing
                    Text(
                      'Support.info@gmail.com',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.defaultTextStyle.copyWith(
                        fontSize: 18,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: AppColors.primaryColor),
              // Phone Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.primaryColor,
                      child: const Icon(Icons.phone, color: AppColors.white),
                    ),
                    const SizedBox(height: 8), // vertical spacing
                    Text(
                      '+8801996655',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.defaultTextStyle.copyWith(
                        fontSize: 18,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
