//
// import 'dart:async';
// import 'package:askfemi/auth/model/auth_flow_model.dart';
// import 'package:askfemi/auth/password/set_new_password_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:pinput/pinput.dart';
// import '../../utils/app_colors.dart';
// import '../../utils/congratulations_screen.dart';
//
// class VerifyEmailScreen extends StatefulWidget {
//   const VerifyEmailScreen({super.key});
//
//   @override
//   State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
// }
//
// class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
//   final pinController = TextEditingController();
//   final focusNode = FocusNode();
//
//   int _countdownSeconds = 30;
//   bool _isTimerActive = true;
//   late Timer _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _startTimer();
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     pinController.dispose();
//     focusNode.dispose();
//     super.dispose();
//   }
//
//   void _startTimer() {
//     _countdownSeconds = 30;
//     _isTimerActive = true;
//
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         if (_countdownSeconds > 0) {
//           _countdownSeconds--;
//         } else {
//           _isTimerActive = false;
//           timer.cancel();
//         }
//       });
//     });
//   }
//
//   void _resendCode() {
//     if (!_isTimerActive) {
//       _startTimer();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Verification code has been resent")),
//       );
//     }
//   }
//
//   void _verifyAndNavigate() {
//     if (pinController.text.length != 6) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter the complete 6-digit code")),
//       );
//       return;
//     }
//
//     // 👇 Check where we came from
//     final authFlow = Get.arguments as AuthFlowModel?;
//
//     if (authFlow == AuthFlowModel.forgotPassword) {
//       Get.off(() => SetNewPasswordScreen()); // Replace current screen
//     } else {
//       Get.off(() => const CongratulationsScreen());
//     }
//   }
//
//   String _formatTime(int seconds) {
//     int minutes = seconds ~/ 60;
//     int remainingSeconds = seconds % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const focusedBorderColor = AppColors.primaryColor;
//     const borderColor = AppColors.grey;
//
//     final defaultPinTheme = PinTheme(
//       width: 56,
//       height: 56,
//       textStyle: const TextStyle(
//         fontSize: 22,
//         color: Color.fromRGBO(30, 60, 87, 1),
//         fontFamily: 'Plus Jakarta Sans',
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: borderColor),
//       ),
//     );
//
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       body: Column(
//         children: [
//           SizedBox(height: MediaQuery.of(context).size.height * 0.15),
//           Center(child: SvgPicture.asset("assets/images/logo.svg")),
//           const Expanded(child: SizedBox()),
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
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 "Verify E-mail",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Plus Jakarta Sans',
//                 ),
//               ),
//               const SizedBox(height: 12),
//               const Text(
//                 textAlign: TextAlign.center,
//                 "Please check your phone number and enter the code",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.normal,
//                   fontFamily: 'Plus Jakarta Sans',
//                   color: Colors.black54,
//                 ),
//               ),
//               const SizedBox(height: 32),
//
//               ///=========================
//               /// PIN Input
//               /// ========================
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Directionality(
//                     textDirection: TextDirection.ltr,
//                     child: Pinput(
//                       length: 6,
//                       controller: pinController,
//                       focusNode: focusNode,
//                       defaultPinTheme: defaultPinTheme,
//                       separatorBuilder: (index) => const SizedBox(width: 8),
//                       focusedPinTheme: defaultPinTheme.copyWith(
//                         decoration: defaultPinTheme.decoration!.copyWith(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: focusedBorderColor),
//                         ),
//                       ),
//                       onCompleted: (pin) {
//                         _verifyAndNavigate();
//                       },
//                       cursor: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Container(
//                             margin: const EdgeInsets.only(bottom: 9),
//                             width: 22,
//                             height: 1,
//                             color: focusedBorderColor,
//                           ),
//                         ],
//                       ),
//                       hapticFeedbackType: HapticFeedbackType.lightImpact,
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//
//                   ///=========================
//                   /// Timer Display
//                   /// ========================
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(CupertinoIcons.clock),
//                       SizedBox(width: 8),
//                       Text(
//                         _formatTime(_countdownSeconds),
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: _isTimerActive ? AppColors.black : Colors.grey,
//                           fontFamily: 'Plus Jakarta Sans',
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 32),
//
//                   ///=========================
//                   /// Verify Button
//                   /// ========================
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.primaryColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       onPressed: _verifyAndNavigate,
//                       child: const Text(
//                         'Verify Email',
//                         style: TextStyle(
//                           fontFamily: 'Plus Jakarta Sans',
//                           color: AppColors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//
//                   ///=========================
//                   /// Resend Code button
//                   /// ========================
//                   RichText(
//                     text: TextSpan(
//                       children: [
//                         TextSpan(
//                           text: "Didn't receive code? ",
//                           style: TextStyle(
//                             color: AppColors.black.withOpacity(0.6),
//                             fontFamily: 'Plus Jakarta Sans',
//                             fontSize: 16,
//                           ),
//                         ),
//                         WidgetSpan(
//                           child: GestureDetector(
//                             onTap: _isTimerActive ? null : _resendCode,
//                             child: Text(
//                               "Resend code",
//                               style: TextStyle(
//                                 color: _isTimerActive ? Colors.grey : AppColors.primaryColor,
//                                 fontFamily: 'Plus Jakarta Sans',
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 decoration: TextDecoration.underline,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';
import 'package:askfemi/auth/model/auth_flow_model.dart';
import 'package:askfemi/auth/password/set_new_password_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../utils/app_colors.dart';
import '../../utils/congratulations_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  int _countdownSeconds = 30;
  bool _isTimerActive = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _startTimer() {
    _countdownSeconds = 30;
    _isTimerActive = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownSeconds > 0) {
          _countdownSeconds--;
        } else {
          _isTimerActive = false;
          timer.cancel();
        }
      });
    });
  }

  void _resendCode() {
    if (!_isTimerActive) {
      _startTimer();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Verification code has been resent")),
      );
    }
  }

  void _verifyAndNavigate() {
    if (pinController.text.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the complete 6-digit code")),
      );
      return;
    }

    // 👇 Check where we came from
    final authFlow = Get.arguments as AuthFlowModel?;

    if (authFlow == AuthFlowModel.forgotPassword) {
      Get.off(() => SetNewPasswordScreen()); // Replace current screen
    } else {
      Get.off(() => const CongratulationsScreen());
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = AppColors.primaryColor;
    const borderColor = AppColors.grey;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontFamily: 'Plus Jakarta Sans',
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          Center(child: SvgPicture.asset("assets/images/logo.svg")),
          const Expanded(child: SizedBox()),
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Verify E-mail",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Plus Jakarta Sans',
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                textAlign: TextAlign.center,
                "Please check your phone number and enter the code",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Plus Jakarta Sans',
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 32),

              ///=========================
              /// PIN Input
              /// ========================
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      length: 6,
                      controller: pinController,
                      focusNode: focusNode,
                      defaultPinTheme: defaultPinTheme,
                      separatorBuilder: (index) => const SizedBox(width: 8),
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: focusedBorderColor),
                        ),
                      ),
                      onCompleted: (pin) {
                        _verifyAndNavigate();
                      },
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 22,
                            height: 1,
                            color: focusedBorderColor,
                          ),
                        ],
                      ),
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                    ),
                  ),
                  const SizedBox(height: 24),

                  ///=========================
                  /// Timer Display
                  /// ========================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.clock),
                      SizedBox(width: 8),
                      Text(
                        _formatTime(_countdownSeconds),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _isTimerActive ? AppColors.black : Colors.grey,
                          fontFamily: 'Plus Jakarta Sans',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  ///=========================
                  /// Verify Button
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
                      onPressed: _verifyAndNavigate,
                      child: const Text(
                        'Verify Email',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  ///=========================
                  /// Resend Code button
                  /// ========================
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Didn't receive code? ",
                          style: TextStyle(
                            color: AppColors.black.withOpacity(0.6),
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 16,
                          ),
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: _isTimerActive ? null : _resendCode,
                            child: Text(
                              "Resend code",
                              style: TextStyle(
                                color: _isTimerActive ? Colors.grey : AppColors.primaryColor,
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}