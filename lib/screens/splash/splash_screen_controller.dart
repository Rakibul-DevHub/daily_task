import 'dart:async';
import 'package:get/get.dart';
import '../../screens/get_started/get_started_screen.dart';

class SplashScreenController {
  final int splashDuration;
  Timer? _timer;

  SplashScreenController({this.splashDuration = 3});

  void startTimer() {
    _timer = Timer(Duration(seconds: splashDuration), () {
      Get.off(
        transition: Transition.fade,
        duration: const Duration(milliseconds: 500),
        () => GetStartedScreen(),
      );
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}



