/**
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_texts_style.dart';
import '../choose_support_mode/choose_support_mode_screen.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key, this.fromProfile = false});

  // Flag to know if navigated from Profile screen
  final bool fromProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: fromProfile
          ? AppBar(
              backgroundColor: AppColors.backgroundColor,
              surfaceTintColor: AppColors.transparent,
              automaticallyImplyLeading: true,
        title: Text("Back",style: AppTextStyles.smallHeading,),
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!fromProfile)
                  Text(
                    textAlign: TextAlign.center,
                    'Choose The Plan That Fits Your Needs',
                    style: AppTextStyles.defaultTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                if (!fromProfile)
                  Text(
                    'Manage tasks efficiently — for yourself or your entire group.',
                    style: AppTextStyles.smallText,
                  ),
                const SizedBox(height: 32),

                // Individual Subscription Card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Bar
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF333333),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Individual Subscription',
                              style: TextStyle(
                                fontFamily: "Plus Jakarta Sans",
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Perfect for individuals who want to manage their own tasks with focus and simplicity.',
                              style: TextStyle(
                                fontFamily: "Plus Jakarta Sans",
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Price
                       Row(
                        children: [
                          Text(
                            '\$10.99',
                            style: AppTextStyles.defaultTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: AppColors.subscriptionPriceTextColor
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '/ Month',
                            style: TextStyle(
                              fontFamily: "Plus Jakarta Sans",
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Basic Monthly Package',
                        style: TextStyle(
                          fontFamily: "Plus Jakarta Sans",
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Free Trial Link
                      if(!fromProfile)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            textAlign: TextAlign.center,
                            'Start Free Trial 7 days',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Plus Jakarta Sans",
                              fontSize: 14,
                              color: AppColors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            CupertinoIcons.link,
                            size: 16,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Button: Cancel if fromProfile, otherwise Get Started
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: fromProfile
                              ? () {
                                  // Cancel subscription logic
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Subscription cancelled!'),
                                    ),
                                  );
                                }
                              : () {
                                  Get.offAll(
                                    () => const ChooseSupportModeScreen(),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: fromProfile
                                ? AppColors.liteRedColor
                                : AppColors.primaryColor,
                            foregroundColor: fromProfile ? AppColors.red : AppColors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            fromProfile
                                ? 'Cancel Subscription'
                                : 'Get Started Now',
                            style: const TextStyle(
                              fontFamily: "Plus Jakarta Sans",
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      _buildFeatureList([
                        'Single-user account',
                        'Create personal tasks',
                        'Start tasks anytime',
                        'Mark tasks as completed',
                        'Private task visibility',
                        'No shared tasks or assignments',
                      ]),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Business Subscription Card
                if(!fromProfile)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.primaryColor, width: 1),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            textAlign: TextAlign.center,
                            'Business Subscription',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Plus Jakarta Sans",
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        textAlign: TextAlign.center,
                        'To create and manage group tasks, please upgrade to the Group Subscription. Visit our website to explore and purchase the Group Plan.',
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: "Plus Jakarta Sans",
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Opening business page...'),
                            ),
                          );
                        },
                        child: const Text(
                          'Learn more at: www.taskmanagement.com',
                          style: TextStyle(
                            fontFamily: "Plus Jakarta Sans",
                            fontSize: 14,
                            color: AppColors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureList(List<String> features) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primaryColor.withOpacity(0.1),
      ),
      child: Column(
        children: features.map((feature) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: AppColors.primaryColor,
                  size: 15,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(feature, style: const TextStyle(fontSize: 14)),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
*/










///
///
///
/// todo:: adding api
///
///
///




import 'package:askfemi/features/individual_user/views/subscription/subscription_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_texts_style.dart';
import 'subscription_controller.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key, this.fromProfile = false});

  // Flag to know if navigated from Profile screen
  final bool fromProfile;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubscriptionController());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: fromProfile
          ? AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.transparent,
        automaticallyImplyLeading: true,
        title: Text("Back", style: AppTextStyles.smallHeading),
      )
          : null,
      body: SafeArea(
        child: Obx(() {
          // Show loading state
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

          // Show error state
          if (controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    controller.errorMessage.value,
                    style: TextStyle(color: Colors.red.shade400),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => controller.fetchSubscriptionData(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final individualPlan = controller.individualPlan.value;

          return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!fromProfile)
                    Text(
                      textAlign: TextAlign.center,
                      'Choose The Plan That Fits Your Needs',
                      style: AppTextStyles.defaultTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  if (!fromProfile)
                    Text(
                      'Manage tasks efficiently — for yourself or your entire group.',
                      style: AppTextStyles.smallText,
                    ),
                  const SizedBox(height: 32),

                  // Individual Subscription Card (from API)
                  if (individualPlan != null)
                    _buildSubscriptionCard(
                      context,
                      individualPlan,
                      fromProfile,
                    ),

                  const SizedBox(height: 32),

                  // Business Subscription Card (only if not from profile)
                  if (!fromProfile)
                    _buildBusinessCard(context),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSubscriptionCard(
      BuildContext context,
      SubscriptionPlan plan,
      bool fromProfile,
      ) {
    final controller = Get.find<SubscriptionController>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bar
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF333333),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan.subscriptionName,
                  style: const TextStyle(
                    fontFamily: "Plus Jakarta Sans",
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  plan.getSubscriptionDescription(),
                  style: const TextStyle(
                    fontFamily: "Plus Jakarta Sans",
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Price
          Row(
            children: [
              Text(
                plan.getFormattedAmount(),
                style: AppTextStyles.defaultTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: AppColors.subscriptionPriceTextColor,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                plan.getFormattedPeriod(),
                style: const TextStyle(
                  fontFamily: "Plus Jakarta Sans",
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            plan.getPackageName(),
            style: const TextStyle(
              fontFamily: "Plus Jakarta Sans",
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),

          // Free Trial Link
          if (!fromProfile && plan.freeTrialEnabled)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  plan.getTrialText(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Plus Jakarta Sans",
                    fontSize: 14,
                    color: AppColors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  CupertinoIcons.link,
                  size: 16,
                  color: AppColors.black,
                ),
              ],
            ),
          const SizedBox(height: 24),

          // Button: Cancel if fromProfile, otherwise Get Started
          SizedBox(
            width: double.infinity,
            child: Obx(() {
              final purchasing = controller.isPurchasing.value;
              return ElevatedButton(
                onPressed: purchasing
                    ? null
                    : fromProfile
                        ? () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Subscription cancelled!'),
                              ),
                            );
                          }
                        : () => controller.purchaseIndividualSubscription(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: fromProfile
                      ? AppColors.liteRedColor
                      : AppColors.primaryColor,
                  foregroundColor:
                      fromProfile ? AppColors.red : AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: purchasing
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        fromProfile
                            ? 'Cancel Subscription'
                            : 'Get Started Now',
                        style: const TextStyle(
                          fontFamily: "Plus Jakarta Sans",
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              );
            }),
          ),
          const SizedBox(height: 16),

          _buildFeatureList(plan.getFeatureList()),
        ],
      ),
    );
  }

  Widget _buildBusinessCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryColor, width: 1),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                textAlign: TextAlign.center,
                'Business Subscription',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Plus Jakarta Sans",
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            textAlign: TextAlign.center,
            'To create and manage group tasks, please upgrade to the Group Subscription. Visit our website to explore and purchase the Group Plan.',
            style: TextStyle(
              fontSize: 13,
              fontFamily: "Plus Jakarta Sans",
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Opening business page...'),
                ),
              );
            },
            child: const Text(
              'Learn more at: www.taskmanagement.com',
              style: TextStyle(
                fontFamily: "Plus Jakarta Sans",
                fontSize: 14,
                color: AppColors.black,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureList(List<String> features) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primaryColor.withOpacity(0.1),
      ),
      child: Column(
        children: features.map((feature) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: AppColors.primaryColor,
                  size: 15,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(feature, style: const TextStyle(fontSize: 14)),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}