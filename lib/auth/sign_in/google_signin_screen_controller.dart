import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../features/group_user/visions/bottom_navigation/ugc_bottom_nav.dart';
import '../../features/individual_user/views/bottom_navigation/main_bottom_nav.dart';
import '../../features/individual_user/views/home/app_open_home_screen.dart';
import '../../screens/get_started/get_started_screen.dart';
import '../../utils/google/google_oauth_config.dart';
import '../../utils/google/id_token_utils.dart';
import '../../utils/network/app_url.dart';
import '../../utils/network/network_caller_dio.dart';
import '../../utils/network/network_response_dio.dart';
import '../../utils/network/secure_storage_service.dart';
import '../model/user_model.dart';

class GoogleSignInScreenController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final NetworkCallerDio _networkCaller = NetworkCallerDio();
  final SecureStorageService _storageService = SecureStorageService.instance;

  final RxBool isLoading = false.obs;
  final RxBool isGoogleSignIn = false.obs;
  final Rxn<UserModel> user = Rxn<UserModel>();
  final RxBool isSubscribed = false.obs;
  bool _googleInitialized = false;

  Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }
    return null;
  }

  Future<void> _initializeGoogleSignIn() async {
    if (_googleInitialized) return;

    debugPrint('🔐 Google Web Client ID: ${GoogleOAuthConfig.webClientId}');
    debugPrint('🔐 Google Android Client ID: ${GoogleOAuthConfig.androidClientId}');
    debugPrint('🔐 Google iOS Client ID: ${GoogleOAuthConfig.iosClientId}');
    debugPrint('🔐 serverClientId (used by app): ${GoogleOAuthConfig.webClientId}');

    await _googleSignIn.initialize(
      serverClientId: GoogleOAuthConfig.webClientId,
    );
    _googleInitialized = true;
    debugPrint('✅ Google Sign-In initialized');
  }

  Future<void> signInWithGoogle() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;
      isGoogleSignIn.value = true;

      await _initializeGoogleSignIn();
      await _googleSignIn.signOut();

      if (!_googleSignIn.supportsAuthenticate()) {
        Get.snackbar(
          'Not Supported',
          'Google Sign-In is not supported on this platform.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final googleUser = await _googleSignIn.authenticate();
      if (googleUser == null) {
        Get.snackbar(
          'Sign-in Cancelled',
          'You cancelled the Google sign-in process.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      debugPrint('✅ Google user: ${googleUser.email}');

      final idToken = googleUser.authentication.idToken;
      if (idToken == null || idToken.isEmpty) {
        Get.snackbar(
          'Google Sign-In Error',
          'Failed to get Google ID token.',
          snackPosition: SnackPosition.BOTTOM,
        );
        await _safeGoogleSignOut();
        return;
      }

      debugPrint('🔑 Google ID token aud: ${IdTokenUtils.audience(idToken)}');
      debugPrint('🔑 Backend should use GOOGLE_CLIENT_ID = ${IdTokenUtils.audience(idToken)}');

      final loggedIn = await _callBackend(idToken: idToken);
      if (!loggedIn) {
        await _safeGoogleSignOut();
      }
    } on GoogleSignInException catch (e) {
      debugPrint('❌ GoogleSignInException: ${e.code} - ${e.description}');
      if (e.code != GoogleSignInExceptionCode.canceled) {
        Get.snackbar(
          'Google Sign-In Failed',
          e.description ?? 'Something went wrong.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      await _safeGoogleSignOut();
    } catch (e, stackTrace) {
      debugPrint('❌ Google sign-in error: $e');
      debugPrintStack(stackTrace: stackTrace);
      Get.snackbar(
        'Sign-in Failed',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      await _safeGoogleSignOut();
    } finally {
      isLoading.value = false;
      isGoogleSignIn.value = false;
    }
  }

  Future<bool> _callBackend({required String idToken}) async {
    try {
      final body = <String, dynamic>{
        'idToken': idToken,
        'role': 'individual',
        'acceptTOC': true,
      };

      debugPrint('📤 Google login body keys: ${body.keys.toList()}');

      final response = await _networkCaller.postRequest(
        AppUrl.googleSignIn,
        body: body,
        isLogin: true,
      );

      if (response.isSuccess) {
        await _handleSuccessfulLogin(response);
        return true;
      }

      debugPrint('❌ Google Login API Error: ${response.errorMessage}');

      final message = response.errorMessage ?? '';
      final isAudienceError = message.toLowerCase().contains('audience') ||
          message.toLowerCase().contains('wrong recipient');

      Get.snackbar(
        'Login Failed',
        isAudienceError
            ? 'Backend GOOGLE_CLIENT_ID is wrong. It must be:\n'
                '${GoogleOAuthConfig.webClientId}'
            : message,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 6),
      );
      return false;
    } catch (e, stackTrace) {
      debugPrint('❌ Backend call error: $e');
      debugPrintStack(stackTrace: stackTrace);
      Get.snackbar(
        'Error',
        'Failed to authenticate with server.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  Future<void> _handleSuccessfulLogin(NetworkResponseDio response) async {
    try {
      debugPrint('✅ Google Login Response: ${response.jsonResponse}');

      final data = _asMap(response.jsonResponse?['data']);
      final attributes = _asMap(data?['attributes']) ?? data;
      final userJson = _asMap(attributes?['userWithoutPassword']) ??
          _asMap(attributes?['user']);

      if (userJson == null) {
        Get.snackbar('Error', 'User data not found.');
        return;
      }

      final loggedInUser = UserModel.fromJson(userJson);
      user.value = loggedInUser;

      final subscription = _asMap(attributes?['subscription']);
      if (subscription != null) {
        isSubscribed.value = subscription['isSubscribed'] == true;
      } else {
        final subscriptionType = userJson['subscriptionType']?.toString();
        isSubscribed.value =
            subscriptionType != null && subscriptionType != 'none';
      }

      final tokens = _asMap(attributes?['tokens']) ?? _asMap(data?['tokens']);
      final accessToken = tokens?['accessToken']?.toString() ??
          attributes?['accessToken']?.toString() ??
          data?['accessToken']?.toString();
      final refreshToken = tokens?['refreshToken']?.toString() ??
          attributes?['refreshToken']?.toString() ??
          data?['refreshToken']?.toString();

      if (accessToken == null || accessToken.isEmpty) {
        debugPrint(
          '❌ Google login response missing accessToken: ${response.jsonResponse}',
        );
        Get.snackbar(
          'Login Incomplete',
          'Google sign-in succeeded but the server did not return an access token.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 6),
        );
        return;
      }

      await _storageService.saveAccessToken(accessToken);
      if (refreshToken != null && refreshToken.isNotEmpty) {
        await _storageService.saveRefreshToken(refreshToken);
      }
      await _storageService.saveUserData(loggedInUser.toJson());
      await _storageService.saveSubscriptionStatus(isSubscribed.value);

      Get.snackbar(
        'Welcome ${loggedInUser.name}!',
        'Successfully signed in with Google.',
        snackPosition: SnackPosition.BOTTOM,
      );

      _navigateByRoleAndSubscription();
    } catch (e, stackTrace) {
      debugPrint('❌ Google login parse error: $e');
      debugPrintStack(stackTrace: stackTrace);
      Get.snackbar('Error', 'Failed to process login response.');
    }
  }

  void _navigateByRoleAndSubscription() {
    final currentUser = user.value;
    if (currentUser == null) return;

    if (currentUser.role == 'child') {
      Get.offAll(() => UgcMainBottomNav());
      return;
    }

    if (currentUser.role == 'individual') {
      if (isSubscribed.value) {
        Get.offAll(() => MainBottomNav());
      } else {
        Get.offAll(() => const AppOpenHomeScreen());
      }
      return;
    }

    Get.offAll(() => GetStartedScreen());
  }

  Future<void> _safeGoogleSignOut() async {
    if (!_googleInitialized) return;
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      debugPrint('⚠️ Google signOut failed: $e');
    }
  }
}
