import 'package:askfemi/auth/model/auth_flow_model.dart';
import 'package:askfemi/auth/verify/verify_email_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../utils/app_colors.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key}) {
    // Initialize the ValueNotifier
    _obscurePassword = ValueNotifier<bool>(true);
  }

  // Use ValueNotifier for password visibility
  late final ValueNotifier<bool> _obscurePassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.45),
          SvgPicture.asset("assets/images/logo.svg"),
        ],
      ),
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(80),
            topRight: Radius.circular(80),
          ),
          border: Border(
            top: BorderSide(color: AppColors.primaryColor, width: 1.5),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Forgot your Password",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Plus Jakarta Sans',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Please enter your phone email to reset password.",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Plus Jakarta Sans',
                ),
              ),
              const SizedBox(height: 24),

              ///===============================
              ///========= E-mail ===========
              ///===============================
              TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.grey, width: 2.0),
                  ),
                  prefixIcon: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.email_rounded, color: Colors.grey[700]),
                          const SizedBox(width: 12),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: VerticalDivider(
                              color: AppColors.grey,
                              width: 1,
                              thickness: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  hintText: 'E-mail',
                  hintStyle: TextStyle(fontFamily: 'Plus Jakarta Sans'),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: AppColors.grey),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              ///=======================
              /// sign in button
              /// ========================
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Get.to(
                          () => VerifyEmailScreen(),
                      arguments: AuthFlowModel.forgotPassword, // 👈 pass this
                    );
                  },
                  child: const Text(
                    'Send OTP',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
