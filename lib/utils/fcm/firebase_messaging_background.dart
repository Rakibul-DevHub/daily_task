import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import '../../firebase_options.dart';
import 'fcm_local_notification_service.dart';

/// Must be a top-level function for background messages.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  debugPrint('📨 Background message: ${message.messageId}');
  debugPrint('📨 Message data: ${message.data}');

  if (message.notification != null) {
    debugPrint('📨 Title: ${message.notification?.title}');
    debugPrint('📨 Body: ${message.notification?.body}');
  }

  await FcmLocalNotificationService.initialize();
  await FcmLocalNotificationService.showFromRemoteMessage(message);
}
