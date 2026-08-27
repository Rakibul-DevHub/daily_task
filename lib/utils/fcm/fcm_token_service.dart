import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'fcm_local_notification_service.dart';

class FcmTokenService {
  FcmTokenService._();

  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static String? _cachedToken;
  static bool _isInitialized = false;

  /// Call once from [main] after Firebase.initializeApp().
  static Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      final settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      if (settings.authorizationStatus != AuthorizationStatus.authorized &&
          settings.authorizationStatus != AuthorizationStatus.provisional) {
        debugPrint('⚠️ Notification permission denied');
        _isInitialized = true;
        return;
      }

      debugPrint('✅ Notification permission granted');
      await FcmLocalNotificationService.initialize();
      await _getAndCacheToken();
      _setupMessageListeners();

      _messaging.onTokenRefresh.listen((String newToken) {
        debugPrint('🔄 FCM token refreshed: $newToken');
        _cachedToken = newToken;
        // Backend currently receives token on login. Re-login or add a
        // dedicated update-fcm endpoint when token refresh happens.
      }).onError((Object error) {
        debugPrint('❌ Token refresh error: $error');
      });

      _isInitialized = true;
    } catch (e) {
      debugPrint('❌ Failed to initialize FCM: $e');
      _isInitialized = true;
    }
  }

  static Future<String> getToken() async {
    if (_cachedToken != null && _cachedToken!.isNotEmpty) {
      return _cachedToken!;
    }

    try {
      final token = await _messaging
          .getToken()
          .timeout(const Duration(seconds: 10), onTimeout: () => null);

      if (token != null && token.isNotEmpty) {
        debugPrint('🔔 FCM token: $token');
        _cachedToken = token;
        return token;
      }

      debugPrint('⚠️ FCM token is null or empty');
      return '';
    } catch (e) {
      debugPrint('❌ Failed to get FCM token: $e');
      return '';
    }
  }

  static void _setupMessageListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('📨 Foreground message: ${message.messageId}');
      debugPrint('📨 Data: ${message.data}');
      FcmLocalNotificationService.showFromRemoteMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('📨 Opened from notification: ${message.data}');
    });
  }

  static Future<void> _getAndCacheToken() async {
    try {
      final token = await _messaging.getToken();
      if (token != null && token.isNotEmpty) {
        _cachedToken = token;
        debugPrint('🔔 FCM token cached: $token');
      }
    } catch (e) {
      debugPrint('❌ Failed to cache FCM token: $e');
    }
  }

  static String? getCachedToken() => _cachedToken;

  static bool get isInitialized => _isInitialized;

  static void clearCache() {
    _cachedToken = null;
    debugPrint('🗑️ FCM token cache cleared');
  }

  static Future<bool> checkPermission() async {
    final settings = await _messaging.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  static Future<void> deleteToken() async {
    try {
      await _messaging.deleteToken();
      _cachedToken = null;
      debugPrint('🗑️ FCM token deleted');
    } catch (e) {
      debugPrint('❌ Failed to delete FCM token: $e');
    }
  }
}
