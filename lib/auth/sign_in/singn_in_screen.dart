import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../forgot_password/forgot_password_screen.dart';
import '../sign_up/sign_up_screen.dart';
import 'google_signin_screen_controller.dart';
import 'manual_sign_in_screen_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key}) {
    _obscurePassword = ValueNotifier<bool>(true);
  }

  late final ValueNotifier<bool> _obscurePassword;

  final ManualSignInScreenController _manualController =
  Get.put(ManualSignInScreenController());

  final GoogleSignInScreenController _googleController =
  Get.put(GoogleSignInScreenController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // late final ValueNotifier<bool> _obscurePassword;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;



    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          /// ================= TOP LOGO =================
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.12),
              child: SvgPicture.asset(
                "assets/images/logo.svg",
                height: height * 0.18,
              ),
            ),
          ),

          /// ================= BOTTOM SHEET (FIXED) =================
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height * 0.65,
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(80),
                  topRight: Radius.circular(80),
                ),
                border: Border(
                  top: BorderSide(
                    color: AppColors.primaryColor,
                    width: 1.5,
                  ),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Sign in your account",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Plus Jakarta Sans',
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Welcome back! Please enter your details.",
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Plus Jakarta Sans',
                      ),
                    ),
                    const SizedBox(height: 24),

                    ///===============================
                    ///========= E-mail ===========
                    ///===============================
                    TextField(
                      controller: emailController,
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
                    const SizedBox(height: 24),

                    ///===============================
                    ///========= Password ===========
                    ///===============================
                    ValueListenableBuilder<bool>(
                      valueListenable: _obscurePassword,
                      builder: (context, isObscured, child) {
                        return TextField(
                          controller: passwordController,
                          obscureText: isObscured,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.grey,
                                width: 2.0,
                              ),
                            ),
                            prefixIcon: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.lock, color: Colors.grey[700]),
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
                            suffixIcon: IconButton(
                              icon: Icon(
                                isObscured ? Icons.visibility_off : Icons.visibility,
                                color: AppColors.grey,
                              ),
                              onPressed: () {
                                // Toggle password visibility
                                _obscurePassword.value = !_obscurePassword.value;
                              },
                            ),
                            hintText: 'Enter Password',
                            hintStyle: TextStyle(fontFamily: 'Plus Jakarta Sans'),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: AppColors.grey),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: AppColors.grey),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.to(()=> ForgotPasswordScreen());
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              color: AppColors.black,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.black,
                              decorationThickness: 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ///=======================
                    /// sign in button
                    /// ========================
                    GetBuilder<ManualSignInScreenController>(
                      builder: (controller) {
                        return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: controller.isLoading
                                ? null
                                : () async {
                              /// Validation
                              if (emailController.text.trim().isEmpty ||
                                  passwordController.text.trim().isEmpty) {
                                Get.snackbar("Error", "Please fill all fields");
                                return;
                              }

                              /// API Call
                              bool success = await controller.signIn(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );

                            },
                            child: controller.isLoading
                                ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                                : const Text(
                              'Sign in',
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),


                    const SizedBox(height: 24),

                    /// ================= SIGN UP =================
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don’t have an account? ",
                            style: TextStyle(
                              color: AppColors.black.withValues(alpha: 0.6),
                              fontFamily: 'Plus Jakarta Sans',
                            ),
                          ),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => SignUpScreen());
                              },
                              child: const Text(
                                "Sign up",
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      "OR",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Plus Jakarta Sans',
                      ),
                    ),
                    const SizedBox(height: 20),

                    GestureDetector(
                      onTap: () {
                        Get.find<GoogleSignInScreenController>()
                            .signInWithGoogle();
                      },
                      child: SvgPicture.asset(
                        "assets/icons/google.svg",
                      ),
                    ),

                    const SizedBox(height: 20),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
