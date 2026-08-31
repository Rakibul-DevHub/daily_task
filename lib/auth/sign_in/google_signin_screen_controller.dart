/**
import 'package:get/get.dart';

class GoogleSignInScreenController extends GetxController {

  Future<void> signInWithGoogle() async {
    await Future.delayed(const Duration(seconds: 1));
    Get.snackbar("Info", "Google Sign-In coming soon 🚀");
  }
}*/








import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

// --- YOUR PROJECT IMPORTS ---
import '../../features/individual_user/views/home/app_open_home_screen.dart';
import '../../screens/get_started/get_started_screen.dart';
import '../../utils/app_colors.dart';
import '../../utils/fcm/fcm_token_service.dart';
import '../../utils/network/app_url.dart';
import '../../utils/network/network_caller_dio.dart';
import '../../utils/network/network_response_dio.dart';
import '../../utils/network/secure_storage_service.dart';
import '../../features/group_user/visions/bottom_navigation/ugc_bottom_nav.dart';
import '../../features/individual_user/views/bottom_navigation/main_bottom_nav.dart';
import '../model/user_model.dart';

class GoogleSignInScreenController extends GetxController {
  // ============================================================
  // GOOGLE SIGN IN
  // ============================================================

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  // ============================================================
  // SERVICES
  // ============================================================

  final NetworkCallerDio _networkCaller = NetworkCallerDio();

  final SecureStorageService _storageService =
      SecureStorageService.instance;

  // ============================================================
  // OBSERVABLES
  // ============================================================

  final RxBool isLoading = false.obs;

  final RxBool isGoogleSignIn = false.obs;

  final Rxn<UserModel> user = Rxn<UserModel>();

  final RxBool isSubscribed = false.obs;

  // ============================================================
  // GOOGLE CONFIGURATION
  // ============================================================

  /*
   * IMPORTANT:
   *
   * Replace this with your WEB CLIENT ID if your backend verifies
   * the Google ID token using the web client ID.
   *
   * Example:
   *
   * 1234567890-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.apps.googleusercontent.com
   *
   * If your Android/iOS configuration already supplies the client ID
   * automatically, you may not need clientId here.
   */
  static const String? _serverClientId = null;

  /*
   * If you need a clientId explicitly, put it here.
   *
   * static const String? _clientId =
   *     'YOUR_CLIENT_ID.apps.googleusercontent.com';
   *
   * Otherwise leave null.
   */
  static const String? _clientId = null;

  bool _googleInitialized = false;

  StreamSubscription<GoogleSignInAuthenticationEvent>?
  _googleAuthSubscription;

  // ============================================================
  // MAP HELPER
  // ============================================================

  Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }

    return null;
  }

  // ============================================================
  // INITIALIZE
  // ============================================================

  Future<void> _initializeGoogleSignIn() async {
    if (_googleInitialized) {
      return;
    }

    try {
      await _googleSignIn.initialize(
        clientId: _clientId,
        serverClientId: _serverClientId,
      );

      _googleInitialized = true;

      debugPrint('✅ Google Sign-In initialized');
    } catch (e, stackTrace) {
      debugPrint(
        '❌ Google Sign-In initialization failed: $e',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }

  // ============================================================
  // SIGN IN WITH GOOGLE
  // ============================================================

  Future<void> signInWithGoogle() async {
    if (isLoading.value) {
      return;
    }

    try {
      isLoading.value = true;
      isGoogleSignIn.value = true;

      // ----------------------------------------------------------
      // Initialize Google Sign-In
      // ----------------------------------------------------------

      await _initializeGoogleSignIn();

      // ----------------------------------------------------------
      // Check platform support
      // ----------------------------------------------------------

      if (!_googleSignIn.supportsAuthenticate()) {
        Get.snackbar(
          'Not Supported',
          'Google Sign-In authentication is not supported on this platform.',
          snackPosition: SnackPosition.BOTTOM,
        );

        return;
      }

      // ----------------------------------------------------------
      // Google Authentication
      // ----------------------------------------------------------

      final GoogleSignInAccount googleUser =
      await _googleSignIn.authenticate();

      if (googleUser == null) {
        Get.snackbar(
          'Sign-in Cancelled',
          'You cancelled the Google sign-in process.',
          snackPosition: SnackPosition.BOTTOM,
        );

        return;
      }

      debugPrint(
        '✅ Google user: ${googleUser.email}',
      );

      // ----------------------------------------------------------
      // Get Google Authentication
      // ----------------------------------------------------------

      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      final String? idToken = googleAuth.idToken;

      if (idToken == null || idToken.isEmpty) {
        debugPrint('❌ Google ID token is null or empty');

        Get.snackbar(
          'Google Sign-In Error',
          'Failed to get Google ID token.',
          snackPosition: SnackPosition.BOTTOM,
        );

        await _safeGoogleSignOut();

        return;
      }

      debugPrint('✅ Google ID token received');

      // ----------------------------------------------------------
      // Show Role Selection
      // ----------------------------------------------------------

      final String? role = await _showRoleSelectionDialog();

      if (role == null || role.isEmpty) {
        await _safeGoogleSignOut();

        Get.snackbar(
          'Cancelled',
          'Role selection was cancelled.',
          snackPosition: SnackPosition.BOTTOM,
        );

        return;
      }

      debugPrint('✅ Selected role: $role');

      // ----------------------------------------------------------
      // Call Backend
      // ----------------------------------------------------------

      await _callBackend(
        idToken: idToken,
        role: role,
      );
    } on GoogleSignInException catch (e, stackTrace) {
      debugPrint(
        '❌ GoogleSignInException: ${e.code} - ${e.description}',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );

      if (e.code == GoogleSignInExceptionCode.canceled) {
        Get.snackbar(
          'Sign-in Cancelled',
          'Google sign-in was cancelled.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Google Sign-In Failed',
          e.description ??
              'Something went wrong while signing in with Google.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFFFE5E5),
          colorText: const Color(0xFFD32F2F),
        );
      }

      await _safeGoogleSignOut();
    } catch (e, stackTrace) {
      debugPrint(
        '❌ Google sign-in error: $e',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );

      Get.snackbar(
        'Sign-in Failed',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFFE5E5),
        colorText: const Color(0xFFD32F2F),
      );

      await _safeGoogleSignOut();
    } finally {
      isLoading.value = false;
      isGoogleSignIn.value = false;
    }
  }

  // ============================================================
  // ROLE SELECTION DIALOG
  // ============================================================

  Future<String?> _showRoleSelectionDialog() async {
    final String? selectedRole = await Get.dialog<String>(
      AlertDialog(
        title: const Text(
          'Choose Account Type',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Please select your account type:',
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRoleButton(
                  role: 'individual',
                ),

                _buildRoleButton(
                  role: 'child',
                ),
              ],
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );

    return selectedRole;
  }

  // ============================================================
  // ROLE BUTTON
  // ============================================================

  Widget _buildRoleButton({
    required String role,
  }) {
    final bool isIndividual = role == 'individual';

    return ElevatedButton(
      onPressed: () {
        Get.back<String>(
          result: role,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isIndividual
            ? AppColors.primaryColor
            : Colors.orange,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),
      ),
      child: Text(
        role.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ============================================================
  // CALL BACKEND
  // ============================================================

  Future<void> _callBackend({
    required String idToken,
    required String role,
  }) async {
    try {
      // ----------------------------------------------------------
      // Get FCM Token
      // ----------------------------------------------------------

      String fcmToken = '';

      try {
        fcmToken = await FcmTokenService.getToken();
      } catch (e) {
        debugPrint(
          '⚠️ Failed to get FCM token: $e',
        );
      }

      // ----------------------------------------------------------
      // Request Body
      // ----------------------------------------------------------

      final Map<String, dynamic> body = {
        'idToken': idToken,
        'role': role,
        'acceptTOC': true,
      };

      if (fcmToken.isNotEmpty) {
        body['fcmToken'] = fcmToken;
      }

      debugPrint(
        '📤 Google Login Request: '
            '${body.keys.toList()}',
      );

      // ----------------------------------------------------------
      // API CALL
      // ----------------------------------------------------------

      final NetworkResponseDio response =
      await _networkCaller.postRequest(
        AppUrl.googleSignIn,
        body: body,
        isLogin: true,
      );

      // ----------------------------------------------------------
      // SUCCESS
      // ----------------------------------------------------------

      if (response.isSuccess) {
        await _handleSuccessfulLogin(
          response,
        );

        return;
      }

      // ----------------------------------------------------------
      // API ERROR
      // ----------------------------------------------------------

      debugPrint(
        '❌ Google Login API Error: '
            '${response.errorMessage}',
      );

      Get.snackbar(
        'Login Failed',
        response.errorMessage ??
            'Could not sign in with Google.',
        snackPosition: SnackPosition.BOTTOM,
      );

      await _safeGoogleSignOut();
    } catch (e, stackTrace) {
      debugPrint(
        '❌ Backend call error: $e',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );

      Get.snackbar(
        'Error',
        'Failed to authenticate with server.',
        snackPosition: SnackPosition.BOTTOM,
      );

      await _safeGoogleSignOut();
    }
  }

  // ============================================================
  // HANDLE SUCCESSFUL LOGIN
  // ============================================================

  Future<void> _handleSuccessfulLogin(
      NetworkResponseDio response,
      ) async {
    try {
      debugPrint(
        '✅ Google Login Response: '
            '${response.jsonResponse}',
      );

      // ----------------------------------------------------------
      // data
      // ----------------------------------------------------------

      final Map<String, dynamic>? data =
      _asMap(response.jsonResponse?['data']);

      if (data == null) {
        debugPrint(
          '❌ Response data is missing',
        );

        Get.snackbar(
          'Error',
          'Invalid server response.',
          snackPosition: SnackPosition.BOTTOM,
        );

        return;
      }

      // ----------------------------------------------------------
      // attributes
      // ----------------------------------------------------------

      final Map<String, dynamic> attributes =
          _asMap(data['attributes']) ?? data;

      // ----------------------------------------------------------
      // USER
      // ----------------------------------------------------------

      final Map<String, dynamic>? userJson =
          _asMap(attributes['userWithoutPassword']) ??
              _asMap(attributes['user']);

      if (userJson == null) {
        debugPrint(
          '❌ Login response missing user: '
              '${response.jsonResponse}',
        );

        Get.snackbar(
          'Error',
          'User data not found.',
          snackPosition: SnackPosition.BOTTOM,
        );

        return;
      }

      // ----------------------------------------------------------
      // Parse User
      // ----------------------------------------------------------

      final UserModel loggedInUser =
      UserModel.fromJson(userJson);

      user.value = loggedInUser;

      debugPrint(
        '✅ Logged in user: ${loggedInUser.name}',
      );

      debugPrint(
        '✅ User role: ${loggedInUser.role}',
      );

      // ----------------------------------------------------------
      // SUBSCRIPTION
      // ----------------------------------------------------------

      final Map<String, dynamic>? subscription =
      _asMap(attributes['subscription']);

      if (subscription != null) {
        final dynamic subscriptionValue =
        subscription['isSubscribed'];

        if (subscriptionValue is bool) {
          isSubscribed.value = subscriptionValue;
        } else if (subscriptionValue is String) {
          isSubscribed.value =
              subscriptionValue.toLowerCase() == 'true';
        } else {
          isSubscribed.value = false;
        }
      } else {
        isSubscribed.value = false;
      }

      // ----------------------------------------------------------
      // TOKENS
      // ----------------------------------------------------------

      final Map<String, dynamic>? tokens =
      _asMap(attributes['tokens']);

      if (tokens == null) {
        debugPrint(
          '❌ Tokens missing from response',
        );

        Get.snackbar(
          'Error',
          'Authentication tokens not found.',
          snackPosition: SnackPosition.BOTTOM,
        );

        return;
      }

      final dynamic accessToken =
      tokens['accessToken'];

      final dynamic refreshToken =
      tokens['refreshToken'];

      if (accessToken == null ||
          accessToken.toString().isEmpty) {
        debugPrint(
          '❌ Access token missing',
        );

        Get.snackbar(
          'Error',
          'Access token not found.',
          snackPosition: SnackPosition.BOTTOM,
        );

        return;
      }

      // ----------------------------------------------------------
      // SAVE ACCESS TOKEN
      // ----------------------------------------------------------

      await _storageService.saveAccessToken(
        accessToken.toString(),
      );

      // ----------------------------------------------------------
      // SAVE REFRESH TOKEN
      // ----------------------------------------------------------

      if (refreshToken != null &&
          refreshToken.toString().isNotEmpty) {
        await _storageService.saveRefreshToken(
          refreshToken.toString(),
        );
      }

      // ----------------------------------------------------------
      // SAVE USER
      // ----------------------------------------------------------

      await _storageService.saveUserData(
        loggedInUser.toJson(),
      );

      // ----------------------------------------------------------
      // SAVE SUBSCRIPTION
      // ----------------------------------------------------------

      await _storageService.saveSubscriptionStatus(
        isSubscribed.value,
      );

      debugPrint(
        '✅ Login data saved successfully',
      );

      // ----------------------------------------------------------
      // SUCCESS MESSAGE
      // ----------------------------------------------------------

      Get.snackbar(
        'Welcome ${loggedInUser.name ?? 'User'}!',
        'Successfully signed in with Google.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFE8F5E9),
        colorText: const Color(0xFF2E7D32),
      );

      // ----------------------------------------------------------
      // NAVIGATE
      // ----------------------------------------------------------

      _navigateByRoleAndSubscription();
    } catch (e, stackTrace) {
      debugPrint(
        '❌ Handle successful login error: $e',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );

      Get.snackbar(
        'Error',
        'Failed to process login response.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // ============================================================
  // NAVIGATION
  // ============================================================

  void _navigateByRoleAndSubscription() {
    final UserModel? currentUser = user.value;

    if (currentUser == null) {
      debugPrint(
        '❌ Cannot navigate: user is null',
      );

      return;
    }

    final String? role = currentUser.role;

    debugPrint(
      '🚀 Navigating with role=$role '
          'subscribed=${isSubscribed.value}',
    );

    // ----------------------------------------------------------
    // CHILD
    // ----------------------------------------------------------

    if (role == 'child') {
      Get.offAll(
            () => UgcMainBottomNav(),
      );

      return;
    }

    // ----------------------------------------------------------
    // INDIVIDUAL
    // ----------------------------------------------------------

    if (role == 'individual') {
      if (isSubscribed.value) {
        Get.offAll(
              () => MainBottomNav(),
        );
      } else {
        Get.offAll(
              () => const AppOpenHomeScreen(),
        );
      }

      return;
    }

    // ----------------------------------------------------------
    // UNKNOWN ROLE
    // ----------------------------------------------------------

    debugPrint(
      '⚠️ Unknown user role: $role',
    );

    Get.offAll(
          () => GetStartedScreen(),
    );
  }

  // ============================================================
  // SAFE GOOGLE SIGN OUT
  // ============================================================

  Future<void> _safeGoogleSignOut() async {
    try {
      if (!_googleInitialized) {
        return;
      }

      await _googleSignIn.signOut();
    } catch (e) {
      debugPrint(
        '⚠️ Google signOut failed: $e',
      );
    }
  }

  // ============================================================
  // SIGN OUT
  // ============================================================

  Future<void> signOutFromGoogle() async {
    if (isLoading.value) {
      return;
    }

    try {
      isLoading.value = true;

      // ----------------------------------------------------------
      // Google Sign Out
      // ----------------------------------------------------------

      await _initializeGoogleSignIn();

      await _googleSignIn.signOut();

      // ----------------------------------------------------------
      // Clear Application Session
      // ----------------------------------------------------------

      await _storageService.clearAll();

      // ----------------------------------------------------------
      // Reset State
      // ----------------------------------------------------------

      isGoogleSignIn.value = false;

      user.value = null;

      isSubscribed.value = false;

      // ----------------------------------------------------------
      // Message
      // ----------------------------------------------------------

      Get.snackbar(
        'Signed Out',
        'You have been signed out successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e, stackTrace) {
      debugPrint(
        '❌ Sign out error: $e',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );

      Get.snackbar(
        'Error',
        'Failed to sign out.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // CHECK EXISTING SESSION
  // ============================================================

  Future<bool> checkSignInStatus() async {
    try {
      // ----------------------------------------------------------
      // First check YOUR application session
      // ----------------------------------------------------------

      final userData =
      await _storageService.getUserData();

      final bool? subscriptionStatus =
      await _storageService.getSubscriptionStatus();

      // ----------------------------------------------------------
      // If application user exists, restore local state
      // ----------------------------------------------------------

      if (userData != null) {
        try {
          user.value = UserModel.fromJson(
            userData,
          );

          isSubscribed.value =
              subscriptionStatus ?? false;

          debugPrint(
            '✅ Existing application session restored',
          );

          return true;
        } catch (e) {
          debugPrint(
            '⚠️ Failed to parse stored user: $e',
          );
        }
      }

      // ----------------------------------------------------------
      // Initialize Google
      // ----------------------------------------------------------

      await _initializeGoogleSignIn();

      // ----------------------------------------------------------
      // Attempt lightweight Google authentication
      // ----------------------------------------------------------

      final GoogleSignInAccount? googleAccount =
      await _googleSignIn
          .attemptLightweightAuthentication();

      if (googleAccount != null) {
        debugPrint(
          '✅ Existing Google account found: '
              '${googleAccount.email}',
        );

        return true;
      }

      debugPrint(
        'ℹ️ No existing Google session',
      );

      return false;
    } catch (e, stackTrace) {
      debugPrint(
        '❌ Check sign-in status error: $e',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );

      return false;
    }
  }

  // ============================================================
  // GOOGLE AUTH EVENT LISTENER
  // ============================================================

  void _listenToGoogleAuthEvents() {
    _googleAuthSubscription?.cancel();

    _googleAuthSubscription =
        _googleSignIn.authenticationEvents.listen(
              (GoogleSignInAuthenticationEvent event) {
            debugPrint(
              'Google authentication event: $event',
            );
          },
          onError: (Object error) {
            debugPrint(
              '❌ Google authentication stream error: $error',
            );
          },
        );
  }

  // ============================================================
  // GETX INIT
  // ============================================================

  @override
  void onInit() {
    super.onInit();

    _initializeController();
  }

  Future<void> _initializeController() async {
    try {
      await _initializeGoogleSignIn();

      _listenToGoogleAuthEvents();

      await checkSignInStatus();
    } catch (e, stackTrace) {
      debugPrint(
        '❌ Google controller initialization error: $e',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );
    }
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void onClose() {
    _googleAuthSubscription?.cancel();

    super.onClose();
  }
}
