import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../features/individual_user/views/subscription/revenuecat_purchase_models.dart';

class RevenueCatService {
  RevenueCatService._();

  static Future<void> purchaseWithConfig(
    RevenueCatPurchaseConfig config,
  ) async {
    if (config.apiKey.isEmpty || config.appUserId.isEmpty) {
      throw Exception('Invalid RevenueCat configuration from server.');
    }

    if (kDebugMode) {
      await Purchases.setLogLevel(LogLevel.debug);
    }

    final configuration = PurchasesConfiguration(config.apiKey)
      ..appUserID = config.appUserId;

    await Purchases.configure(configuration);

    final offerings = await Purchases.getOfferings();
    final current = offerings.current;

    Package? selectedPackage;

    if (current != null && config.packageIdentifier.isNotEmpty) {
      selectedPackage = current.getPackage(config.packageIdentifier);
    }

    if (selectedPackage == null && current != null) {
      for (final package in current.availablePackages) {
        if (package.storeProduct.identifier == config.productIdentifier) {
          selectedPackage = package;
          break;
        }
      }
    }

    if (selectedPackage == null) {
      throw Exception(
        'Subscription package "${config.packageIdentifier}" was not found in RevenueCat.',
      );
    }

    await Purchases.purchase(PurchaseParams.package(selectedPackage));
  }

  static bool isUserCancelled(Object error) {
    if (error is PlatformException) {
      final code = PurchasesErrorHelper.getErrorCode(error);
      return code == PurchasesErrorCode.purchaseCancelledError;
    }
    return false;
  }
}
