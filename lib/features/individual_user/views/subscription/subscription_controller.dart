import 'package:askfemi/features/individual_user/views/subscription/revenuecat_purchase_models.dart';
import 'package:askfemi/features/individual_user/views/subscription/subscription_models.dart';
import 'package:get/get.dart';

import '../../../../utils/network/app_url.dart';
import '../../../../utils/network/network_caller_dio.dart';
import '../../../../utils/network/secure_storage_service.dart';
import '../../../../utils/subscription/revenuecat_service.dart';
import '../choose_support_mode/choose_support_mode_screen.dart';

class SubscriptionController extends GetxController {
  final NetworkCallerDio _networkCaller = NetworkCallerDio();

  var isLoading = false.obs;
  var isPurchasing = false.obs;
  var errorMessage = RxString('');
  var subscriptionResponse = Rx<SubscriptionResponse?>(null);
  var individualPlan = Rx<SubscriptionPlan?>(null);
  var hasSubscription = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubscriptionData();
  }

  Future<Map<String, String>?> _authHeaders() async {
    final token = await SecureStorageService.instance.getAccessToken();
    if (token == null || token.isEmpty) {
      errorMessage.value = 'No access token found';
      return null;
    }
    return {'Authorization': 'Bearer $token'};
  }

  Future<void> fetchSubscriptionData() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final headers = await _authHeaders();
      if (headers == null) {
        isLoading.value = false;
        return;
      }

      final response = await _networkCaller.getRequest(
        AppUrl.getSubscription,
        headers: headers,
      );

      if (response.isSuccess && response.jsonResponse != null) {
        final subscriptionData =
            SubscriptionResponse.fromJson(response.jsonResponse!);
        subscriptionResponse.value = subscriptionData;

        if (subscriptionData.data.attributes.results.isNotEmpty) {
          individualPlan.value =
              subscriptionData.data.attributes.results.firstWhere(
            (plan) => plan.subscriptionType == 'individual',
            orElse: () => subscriptionData.data.attributes.results.first,
          );
          hasSubscription.value = true;
        } else {
          hasSubscription.value = false;
        }
      } else {
        errorMessage.value =
            response.errorMessage ?? 'Failed to load subscription data';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> purchaseIndividualSubscription() async {
    final plan = individualPlan.value;
    if (plan == null || plan.subscriptionId.isEmpty) {
      Get.snackbar('Error', 'No subscription plan available.');
      return false;
    }

    isPurchasing.value = true;
    errorMessage.value = '';

    try {
      final headers = await _authHeaders();
      if (headers == null) {
        Get.snackbar('Error', errorMessage.value);
        return false;
      }

      final response = await _networkCaller.postRequest(
        AppUrl.getSubscriptionRevenuecat(plan.subscriptionId),
        body: {},
        headers: headers,
        isLogin: false,
      );

      if (!response.isSuccess || response.jsonResponse == null) {
        final message =
            response.errorMessage ?? 'Failed to start subscription purchase.';
        errorMessage.value = message;
        Get.snackbar('Purchase Failed', message);
        return false;
      }

      final purchaseConfig = RevenueCatPurchaseResponse.fromJson(
        Map<String, dynamic>.from(response.jsonResponse!),
      ).config;

      await RevenueCatService.purchaseWithConfig(purchaseConfig);

      await SecureStorageService.instance.saveSubscriptionStatus(true);
      hasSubscription.value = true;

      Get.snackbar(
        'Success',
        'Subscription purchased successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );

      Get.offAll(() => const ChooseSupportModeScreen());
      return true;
    } catch (e) {
      if (RevenueCatService.isUserCancelled(e)) {
        return false;
      }

      final message = e.toString().replaceFirst('Exception: ', '');
      errorMessage.value = message;
      Get.snackbar('Purchase Failed', message);
      return false;
    } finally {
      isPurchasing.value = false;
    }
  }

  SubscriptionPlan? getIndividualPlan() => individualPlan.value;

  bool hasActiveSubscription() {
    return individualPlan.value != null && individualPlan.value!.isActive;
  }

  void cancelSubscription() {
    // TODO: implement cancel subscription API when available
  }
}
