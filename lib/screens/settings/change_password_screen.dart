import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_texts_style.dart';
import '../../../../utils/static_text.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  // Control visibility for each field
  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.transparent,
        foregroundColor: AppColors.iconColor,
        title: Text(
          "Change Password",
          style: AppTextStyles.smallHeading?.copyWith(
            color: AppColors.iconColor,
          ),
        ),
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_outlined,color: AppColors.iconColor,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Old Password Field
              TextField(
                obscureText: !_isOldPasswordVisible,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.primaryColor ?? Colors.blue, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.grey, width: 1.0),
                  ),
                  prefixIcon: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.lock, color: AppColors.iconColor),
                          const SizedBox(width: 12),
                          VerticalDivider(
                            color: AppColors.grey,
                            width: 2,
                            indent: 6,
                            endIndent: 6,
                            thickness: 1.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isOldPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.iconColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _isOldPasswordVisible = !_isOldPasswordVisible;
                      });
                    },
                  ),
                  hintText: 'Old Password',
                  hintStyle: const TextStyle(fontFamily: 'Plus Jakarta Sans', color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16),

              // New Password Field
              TextField(
                obscureText: !_isNewPasswordVisible,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.grey, width: 1.0),
                  ),
                  prefixIcon: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.lock, color: AppColors.iconColor),
                          const SizedBox(width: 12),
                          VerticalDivider(
                            color: AppColors.grey,
                            width: 2,
                            indent: 6,
                            endIndent: 6,
                            thickness: 1.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.iconColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _isNewPasswordVisible = !_isNewPasswordVisible;
                      });
                    },
                  ),
                  hintText: 'New Password',
                  hintStyle: const TextStyle(fontFamily: 'Plus Jakarta Sans', color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16),

              /// ----------------------
              /// Confirm Password Field
              /// ----------------------
              TextField(
                obscureText: !_isConfirmPasswordVisible,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.grey, width: 1.0),
                  ),
                  prefixIcon: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.lock, color: AppColors.iconColor),
                          const SizedBox(width: 12),
                          VerticalDivider(
                            color: AppColors.grey,
                            width: 2,
                            indent: 6,
                            endIndent: 6,
                            thickness: 1.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.iconColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                  hintText: 'Confirm Password',
                  hintStyle: const TextStyle(fontFamily: 'Plus Jakarta Sans', color: Colors.grey),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Forgot Password?",style: AppTextStyles.smallText.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.grey,
                    color: AppColors.black,
                    fontSize: 14,
                  ),)
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    // Handle save logic here
                  },
                  child: Text('Change Password',style: AppTextStyles.smallText.copyWith(
                    fontSize: 18,color: AppColors.white,fontWeight: FontWeight.bold
                  ),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}