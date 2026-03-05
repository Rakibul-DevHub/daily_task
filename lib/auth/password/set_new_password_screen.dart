//
// import 'package:askfemi/auth/sign_in/singn_in_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import '../../utils/app_colors.dart';
//
// class SetNewPasswordScreen extends StatelessWidget {
//   SetNewPasswordScreen({super.key}) {
//     _obscurePassword = ValueNotifier<bool>(true);
//     _obscureConfirmPassword = ValueNotifier<bool>(true);
//   }
//
//   late final ValueNotifier<bool> _obscurePassword;
//   late final ValueNotifier<bool> _obscureConfirmPassword;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       body: Column(
//         children: [
//           // Top logo section
//           SizedBox(height: MediaQuery.of(context).size.height * 0.15),
//           Center(
//             child: SvgPicture.asset(
//               "assets/images/logo.svg",
//               height: 130,
//               width: 130,
//               semanticsLabel: 'App Logo',
//             ),
//           ),
//           const Spacer(),
//         ],
//       ),
//       bottomSheet: Container(
//         height: MediaQuery.of(context).size.height * 0.65,
//         width: double.infinity,
//         padding: const EdgeInsets.all(24),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(80),
//             topRight: Radius.circular(80),
//           ),
//           border: Border(
//             top: BorderSide(color: AppColors.primaryColor, width: 1.5),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 8),
//             const Center(
//               child: Text(
//                 "Set New Password",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Plus Jakarta Sans',
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),
//
//
//             /// New Password Field
//             ValueListenableBuilder<bool>(
//               valueListenable: _obscurePassword,
//               builder: (context, isObscured, _) {
//                 return TextField(
//                   style: TextStyle(
//                     fontFamily: 'Plus Jakarta Sans',
//                       color: AppColors.black
//                   ),
//                   obscureText: isObscured,
//                   decoration: _inputDecoration(
//                     hint: "New password",
//                     isObscured: isObscured,
//                     onToggle: () {
//                       _obscurePassword.value = !_obscurePassword.value;
//                     },
//                   ),
//                 );
//               },
//             ),
//
//             const SizedBox(height: 20),
//
//             /// Confirm Password Field
//             ValueListenableBuilder<bool>(
//               valueListenable: _obscureConfirmPassword,
//               builder: (context, isObscured, _) {
//                 return TextField(
//                   style: TextStyle(
//                       fontFamily: 'Plus Jakarta Sans',
//                     color: AppColors.black
//                   ),
//                   obscureText: isObscured,
//                   decoration: _inputDecoration(
//                     hint: "Confirm password",
//                     isObscured: isObscured,
//                     onToggle: () {
//                       _obscureConfirmPassword.value = !_obscureConfirmPassword.value;
//                     },
//                   ),
//                 );
//               },
//             ),
//
//             const SizedBox(height: 8),
//
//             /// Password requirements
//             Padding(
//               padding: const EdgeInsets.only(left: 4, top: 8),
//               child: Text(
//                 "• At least 8 characters\n• One uppercase letter\n• One number\n• One special character",
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontFamily: 'Plus Jakarta Sans',
//                   color: Colors.grey[600],
//                   height: 1.5,
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 30),
//
//             /// Save Password Button
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primaryColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 0,
//                 ),
//                 onPressed: () {
//                   _showSuccessBottomSheet(context);
//                 },
//                 child: const Text(
//                   'Save Password',
//                   style: TextStyle(
//                     fontFamily: 'Plus Jakarta Sans',
//                     color: AppColors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// Input Decoration with vertical divider
//   InputDecoration _inputDecoration({
//     required String hint,
//     required bool isObscured,
//     required VoidCallback onToggle,
//   }) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: const TextStyle(
//         fontFamily: 'Plus Jakarta Sans',
//         color: Colors.grey,
//       ),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       prefixIcon: Container(
//         padding: const EdgeInsets.only(left: 16, right: 12),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(Icons.lock_outline, color: AppColors.iconColor, size: 20),
//             const SizedBox(width: 12),
//             Container(
//               height: 24,
//               width: 1,
//               color: Colors.grey[300],
//             ),
//           ],
//         ),
//       ),
//       suffixIcon: IconButton(
//         icon: Icon(
//           isObscured
//               ? Icons.visibility_off
//               : Icons.visibility,
//           color:  AppColors.iconColor,
//         ),
//         onPressed: onToggle,
//       ),
//       filled: true,
//       fillColor: Colors.grey[50],
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.grey[300]!),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.grey[300]!),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
//       ),
//     );
//   }
//
//   /// Success Bottom Sheet
//   void _showSuccessBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isDismissible: false,
//       enableDrag: false,
//       backgroundColor: Colors.transparent,
//       builder: (_) {
//         return Container(
//           height: MediaQuery.of(context).size.height * 0.5,
//           padding: const EdgeInsets.all(24),
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(
//               top: Radius.circular(30),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 20,
//                 spreadRadius: 5,
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               /// Success Icon
//               Container(
//                 height: 100,
//                 width: 100,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: AppColors.primaryColor.withOpacity(0.1),
//                 ),
//                 child: Center(
//                   child: SvgPicture.asset("assets/icons/key.svg",
//                   height: 150,
//                   width: 150,),
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               /// Success Title
//               const Text(
//                 "Password Update Successfully",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Plus Jakarta Sans',
//                   color: Colors.black,
//                 ),
//               ),
//
//               const SizedBox(height: 8),
//
//               /// Success Message
//               const Text(
//                 "Return to the login page to enter your account with your new password.",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'Plus Jakarta Sans',
//                   color: Colors.black54,
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               /// Go to Homepage Button
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   onPressed: () {
//                     Get.offAll(SignInScreen());
//                   },
//                   child: const Text(
//                     "Go to Sign in",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontFamily: 'Plus Jakarta Sans',
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }


import 'package:askfemi/auth/sign_in/singn_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';

class SetNewPasswordScreen extends StatelessWidget {
  SetNewPasswordScreen({super.key}) {
    _obscurePassword = ValueNotifier<bool>(true);
    _obscureConfirmPassword = ValueNotifier<bool>(true);
  }

  late final ValueNotifier<bool> _obscurePassword;
  late final ValueNotifier<bool> _obscureConfirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          // Top logo section
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          Center(
            child: SvgPicture.asset(
              "assets/images/logo.svg",
              height: 130,
              width: 130,
              semanticsLabel: 'App Logo',
            ),
          ),
          const Spacer(),
        ],
      ),
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration:  BoxDecoration(
          color: AppColors.backgroundColor, // Changed to yellow
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(80),
            topRight: Radius.circular(80),
          ),
          border: Border(
            top: BorderSide(color: AppColors.primaryColor, width: 1.5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Center(
              child: Text(
                "Set New Password",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Plus Jakarta Sans',
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 24),

            /// New Password Field
            ValueListenableBuilder<bool>(
              valueListenable: _obscurePassword,
              builder: (context, isObscured, _) {
                return TextField(
                  style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: AppColors.black
                  ),
                  obscureText: isObscured,
                  decoration: _inputDecoration(
                    hint: "New password",
                    isObscured: isObscured,
                    onToggle: () {
                      _obscurePassword.value = !_obscurePassword.value;
                    },
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            /// Confirm Password Field
            ValueListenableBuilder<bool>(
              valueListenable: _obscureConfirmPassword,
              builder: (context, isObscured, _) {
                return TextField(
                  style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: AppColors.black
                  ),
                  obscureText: isObscured,
                  decoration: _inputDecoration(
                    hint: "Confirm password",
                    isObscured: isObscured,
                    onToggle: () {
                      _obscureConfirmPassword.value = !_obscureConfirmPassword.value;
                    },
                  ),
                );
              },
            ),

            const SizedBox(height: 8),

            /// Password requirements
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 8),
              child: Text(
                "• At least 8 characters\n• One uppercase letter\n• One number\n• One special character",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Plus Jakarta Sans',
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// Save Password Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  _showSuccessBottomSheet(context);
                },
                child: const Text(
                  'Save Password',
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
    );
  }

  /// Input Decoration with vertical divider
  InputDecoration _inputDecoration({
    required String hint,
    required bool isObscured,
    required VoidCallback onToggle,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        color: Colors.grey,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      prefixIcon: Container(
        padding: const EdgeInsets.only(left: 16, right: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock_outline, color: AppColors.iconColor, size: 20),
            const SizedBox(width: 12),
            Container(
              height: 24,
              width: 1,
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
      suffixIcon: IconButton(
        icon: Icon(
          isObscured
              ? Icons.visibility_off
              : Icons.visibility,
          color: AppColors.iconColor,
        ),
        onPressed: onToggle,
      ),
      filled: true,
      fillColor: Colors.grey[50],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
      ),
    );
  }

  /// Success Bottom Sheet
  void _showSuccessBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.all(24),
          decoration:  BoxDecoration(
            color: AppColors.backgroundColor, // Changed to yellow
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Success Icon
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor.withOpacity(0.1),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/key.svg",
                    height: 150,
                    width: 150,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// Success Title
              const Text(
                "Password Update Successfully",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Plus Jakarta Sans',
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 8),

              /// Success Message
              const Text(
                "Return to the login page to enter your account with your new password.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Plus Jakarta Sans',
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 24),

              /// Go to Sign In Button
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
                    Get.offAll(() =>  SignInScreen());
                  },
                  child: const Text(
                    "Go to Sign in",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}