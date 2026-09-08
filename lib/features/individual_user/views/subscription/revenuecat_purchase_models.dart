class RevenueCatPurchaseConfig {
  final String apiKey;
  final String appUserId;
  final String productIdentifier;
  final String packageIdentifier;
  final RevenueCatPlanDetails? planDetails;

  RevenueCatPurchaseConfig({
    required this.apiKey,
    required this.appUserId,
    required this.productIdentifier,
    required this.packageIdentifier,
    this.planDetails,
  });

  factory RevenueCatPurchaseConfig.fromJson(Map<String, dynamic> json) {
    return RevenueCatPurchaseConfig(
      apiKey: json['apiKey']?.toString() ?? '',
      appUserId: json['appUserId']?.toString() ?? '',
      productIdentifier: json['productIdentifier']?.toString() ?? '',
      packageIdentifier: json['packageIdentifier']?.toString() ?? '',
      planDetails: json['planDetails'] is Map
          ? RevenueCatPlanDetails.fromJson(
              Map<String, dynamic>.from(json['planDetails']),
            )
          : null,
    );
  }
}

class RevenueCatPlanDetails {
  final String subscriptionName;
  final String subscriptionType;
  final String amount;
  final String currency;

  RevenueCatPlanDetails({
    required this.subscriptionName,
    required this.subscriptionType,
    required this.amount,
    required this.currency,
  });

  factory RevenueCatPlanDetails.fromJson(Map<String, dynamic> json) {
    return RevenueCatPlanDetails(
      subscriptionName: json['subscriptionName']?.toString() ?? '',
      subscriptionType: json['subscriptionType']?.toString() ?? '',
      amount: json['amount']?.toString() ?? '',
      currency: json['currency']?.toString() ?? '',
    );
  }
}

class RevenueCatPurchaseResponse {
  final RevenueCatPurchaseConfig config;

  RevenueCatPurchaseResponse({required this.config});

  factory RevenueCatPurchaseResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final attributes = data is Map ? data['attributes'] : null;
    return RevenueCatPurchaseResponse(
      config: RevenueCatPurchaseConfig.fromJson(
        attributes is Map ? Map<String, dynamic>.from(attributes) : {},
      ),
    );
  }
}
