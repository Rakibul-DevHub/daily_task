import 'package:askfemi/auth/forgot_password/forgot_password_screen.dart';
import 'package:askfemi/features/group_user/visions/bottom_navigation/ugc_bottom_nav.dart';
import 'package:askfemi/features/group_user/visions/ugc_task_status/ugc_task_status_screen.dart';
import 'package:askfemi/features/individual_user/views/home/app_open_home_screen.dart';
import 'package:askfemi/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'utils/fcm/firebase_messaging_background.dart';
import 'utils/fcm/fcm_token_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await GetStorage.init();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FcmTokenService.initialize();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const TaskManagement());
}

class TaskManagement extends StatelessWidget {
  const TaskManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Management',
      home: const SplashScreen(),
      // home: AppOpenHomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}