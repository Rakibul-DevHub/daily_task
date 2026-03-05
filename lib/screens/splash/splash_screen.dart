import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import 'splash_screen_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashScreenController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SplashScreenController(splashDuration: 4);
    _controller.startTimer();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/icons/logo.gif',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: Transform.translate(
          //     offset: const Offset(0, -200),
          //     // moves the image up by half its height
          //     child: Image.asset(
          //       "assets/images/splash_screen_top_shade.png",
          //       width: 500,
          //       height: 500,
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}



