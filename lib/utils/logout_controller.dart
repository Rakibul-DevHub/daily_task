/**
// utils/logout_controller.dart
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../utils/network/app_url.dart';
import '../utils/network/secure_storage_service.dart';
import '../utils/temp/cache.dart';
import '../../auth/sign_in/singn_in_screen.dart';

class LogoutController extends GetxController {
  final Dio _dio = Dio();

  var isLoading = false.obs;
  var errorMessage = RxString('');

  // In LogoutController
  Future<void> logout() async {
    print('🔴 LOGOUT METHOD CALLED - STARTING');
    if (isLoading.value) {
      print('🔴 Already loading, skipping');
      return;
    }

    isLoading.value = true;
    print('🔴 isLoading set to true');

    try {
      final token = await SecureStorageService.instance.getAccessToken();
      print('🔴 Token retrieved: ${token != null ? "Yes" : "No"}');

      final url = AppUrl.logOut;
      print('🌐 Making POST request to: $url');

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
        print('🔴 Authorization header added');
      }

      print('🔴 Headers: $headers');

      final response = await _dio.post(
        url,
        options: Options(
          headers: headers,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      print('📡 Response status code: ${response.statusCode}');
      print('📡 Response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Logout API successful');
      } else {
        print('⚠️ Logout API returned status: ${response.statusCode}');
      }

      print('🔴 Clearing local data...');
      await _clearLocalDataAndNavigate();
      print('🔴 Local data cleared and navigated');

    } on DioException catch (e) {
      print('❌ DioException: ${e.message}');
      print('❌ Response: ${e.response?.data}');
      print('❌ Status code: ${e.response?.statusCode}');
      await _clearLocalDataAndNavigate();
    } catch (e) {
      print('❌ Error during logout: $e');
      await _clearLocalDataAndNavigate();
    } finally {
      isLoading.value = false;
      print('🔴 Logout completed, isLoading set to false');
    }
  }

  Future<void> _clearLocalDataAndNavigate() async {
    try {
      await SecureStorageService.instance.clearAll();
      await CacheService.clearCache();
      Get.offAll(() =>  SignInScreen());
    } catch (e) {
      Get.offAll(() =>  SignInScreen());
    }
  }
}*/








// utils/logout_controller.dart
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../utils/fcm/fcm_token_service.dart';
import '../utils/network/app_url.dart';
import '../utils/network/secure_storage_service.dart';
import '../utils/temp/cache.dart';
import '../../auth/sign_in/singn_in_screen.dart';

class LogoutController extends GetxController {
  final Dio _dio = Dio();

  var isLoading = false.obs;
  var errorMessage = RxString('');

  // Updated logout method with refreshToken in body
  Future<void> logout() async {
    print('🔴 LOGOUT METHOD CALLED - STARTING');
    if (isLoading.value) {
      print('🔴 Already loading, skipping');
      return;
    }

    isLoading.value = true;
    print('🔴 isLoading set to true');

    try {
      final token = await SecureStorageService.instance.getAccessToken();
      final refreshToken = await SecureStorageService.instance.getRefreshToken();

      print('🔴 Token retrieved: ${token != null ? "Yes" : "No"}');
      print('🔴 Refresh Token retrieved: ${refreshToken != null ? "Yes" : "No"}');

      final url = AppUrl.logOut;
      print('🌐 Making POST request to: $url');

      // Prepare request body with refreshToken
      final Map<String, dynamic> requestBody = {};
      if (refreshToken != null && refreshToken.isNotEmpty) {
        requestBody["refreshToken"] = refreshToken;
        print('🔴 Refresh token added to body');
      } else {
        print('⚠️ No refresh token found for logout');
      }

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
        print('🔴 Authorization header added');
      }

      print('🔴 Headers: $headers');
      print('🔴 Request Body: $requestBody');

      final response = await _dio.post(
        url,
        data: requestBody.isNotEmpty ? requestBody : null,
        options: Options(
          headers: headers,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      print('📡 Response status code: ${response.statusCode}');
      print('📡 Response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Logout API successful');
      } else {
        print('⚠️ Logout API returned status: ${response.statusCode}');
      }

      print('🔴 Clearing local data...');
      await _clearLocalDataAndNavigate();
      print('🔴 Local data cleared and navigated');

    } on DioException catch (e) {
      print('❌ DioException: ${e.message}');
      print('❌ Response: ${e.response?.data}');
      print('❌ Status code: ${e.response?.statusCode}');
      // Even if API fails, clear local data and navigate
      await _clearLocalDataAndNavigate();
    } catch (e) {
      print('❌ Error during logout: $e');
      await _clearLocalDataAndNavigate();
    } finally {
      isLoading.value = false;
      print('🔴 Logout completed, isLoading set to false');
    }
  }

  Future<void> _clearLocalDataAndNavigate() async {
    try {
      await FcmTokenService.deleteToken();
      FcmTokenService.clearCache();
      await SecureStorageService.instance.clearAll();
      await CacheService.clearCache();
      Get.offAll(() =>  SignInScreen());
    } catch (e) {
      print('❌ Error clearing local data: $e');
      Get.offAll(() =>  SignInScreen());
    }
  }
}