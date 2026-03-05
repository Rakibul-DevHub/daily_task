import 'package:flutter/material.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_texts_style.dart';
import '../../../../utils/static_text.dart';

class AboutUsPrivacyPolicyTermsConditionScreen extends StatelessWidget {
  const AboutUsPrivacyPolicyTermsConditionScreen({
    super.key,
    required this.pageTitle,
    required this.content,
  });

  final String pageTitle;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.iconColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(pageTitle, style: AppTextStyles.smallHeading),
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Last Update Feb 2026",style: AppTextStyles.smallText.copyWith(
                color: AppColors.textColorBlue,fontSize: 14
              ),),
              const SizedBox(height: 12),
              Text(pageTitle, style: AppTextStyles.smallHeading),
              SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width *
                      2,
                  child: Text(
                    content,
                    textAlign: TextAlign.justify, // 👈 justify both sides
                    style: AppTextStyles.defaultTextStyle.copyWith(
                      height: 1.6,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
