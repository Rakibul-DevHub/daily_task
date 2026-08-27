import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../features/individual_user/views/home/app_open_home_screen.dart';
import '../../screens/get_started/get_started_screen.dart';
import '../../utils/fcm/fcm_token_service.dart';
import '../../utils/network/app_url.dart';
import '../../utils/network/network_caller_dio.dart';
import '../../utils/network/network_response_dio.dart';
import '../../utils/network/secure_storage_service.dart';
import '../model/user_model.dart';
import '../../features/group_user/visions/bottom_navigation/ugc_bottom_nav.dart';
import '../../features/individual_user/views/bottom_navigation/main_bottom_nav.dart';

class ManualSignInScreenController extends GetxController {
  final NetworkCallerDio _networkCaller = NetworkCallerDio();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserModel? loggedInUser;
  bool isSubscribed = false;

  Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }
    return null;
  }

  /// ================= LOGIN =================
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    update();

    final fcmToken = await FcmTokenService.getToken();

    final body = <String, dynamic>{
      'email': email,
      'password': password,
    };

    if (fcmToken.isNotEmpty) {
      body['fcmToken'] = fcmToken;
    }

    NetworkResponseDio response = await _networkCaller.postRequest(
      AppUrl.loginIndividualAndChildren,
      body: body,
      isLogin: true,
    );

    _isLoading = false;
    update();

    if (response.isSuccess) {
      try {
        final data = _asMap(response.jsonResponse?['data']);
        final attributes = _asMap(data?['attributes']) ?? data;

        final userJson = _asMap(attributes?['userWithoutPassword']) ??
            _asMap(attributes?['user']);
        if (userJson == null) {
          debugPrint('❌ Login response: ${response.jsonResponse}');
          Get.snackbar('Error', 'User data not found');
          return false;
        }

        loggedInUser = UserModel.fromJson(userJson);

        final subscription = _asMap(attributes?['subscription']);
        if (subscription != null) {
          isSubscribed = subscription['isSubscribed'] ?? false;
          print('📋 Subscription status: isSubscribed = $isSubscribed');
        }

        final tokens = _asMap(attributes?['tokens']);
        final accessToken = tokens?['accessToken'];
        final refreshToken = tokens?['refreshToken'];

        if (accessToken == null) {
          Get.snackbar('Error', 'Access token not found');
          return false;
        }

        await SecureStorageService.instance.saveAccessToken(accessToken);
        if (refreshToken != null) {
          await SecureStorageService.instance.saveRefreshToken(refreshToken);
        }

        await SecureStorageService.instance.saveUserData(loggedInUser!.toJson());
        await SecureStorageService.instance.saveSubscriptionStatus(isSubscribed);

        _navigateByRoleAndSubscription();

        return true;
      } catch (e) {
        Get.snackbar('Error', 'Parsing failed: ${e.toString()}');
        return false;
      }
    } else {
      Get.snackbar(
        'Login Failed',
        response.errorMessage ?? 'Something went wrong',
      );
      return false;
    }
  }

  /// ================= ROLE & SUBSCRIPTION NAVIGATION =================
  void _navigateByRoleAndSubscription() {
    if (loggedInUser == null) return;

    if (loggedInUser!.role == 'child') {
      Get.offAll(() => UgcMainBottomNav());
      return;
    }

    if (loggedInUser!.role == 'individual') {
      if (isSubscribed) {
        print('✅ User has active subscription - navigating to MainBottomNav');
        Get.offAll(() => MainBottomNav());
      } else {
        print('⚠️ User has no active subscription - navigating to AppOpenHomeScreen');
        Get.offAll(() => const AppOpenHomeScreen());
      }
      return;
    }

    Get.offAll(() => GetStartedScreen());
  }

  bool getSubscriptionStatus() {
    return isSubscribed;
  }
}
