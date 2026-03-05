import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_texts_style.dart';
import '../../../../utils/static_text.dart';
import '../subscription/subscription_screen.dart';

class AppOpenHomeScreen extends StatelessWidget {
  const AppOpenHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row: Greeting + Notification Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage("assets/images/dummy_user_image.png"),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),

                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back!',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const Text(
                            'Hi, Rakibul',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    "assets/icons/notification_rounded.svg",
                    fit: BoxFit.fitHeight,
                    height: 40,
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Title Section
              Center(
                child: Column(
                  children: [
                    Text(
                      'Start Your Day',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF5C9FFB),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'What would you like to focus on today?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Illustration Image (Placeholder)
              Center(
                child: SvgPicture.asset("assets/images/app_open_home_screen_image.svg",
                height: MediaQuery.of(context).size.height * 0.5,
                fit: BoxFit.contain,),
              ),
              const SizedBox(height: 60),

              // Add Task Button
              ElevatedButton(
                onPressed: () {
                  _showSubscriptionModal(context); // 👈 Trigger modal
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5C9FFB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Add Task',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showSubscriptionModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: SvgPicture.asset(
                  "assets/icons/task.svg", // 👈 Use your own SVG or replace with Icon
                  width: 80,
                  height: 80,
                  color: const Color(0xFF5C9FFB),
                ),
              ),

              // Title
               Text(
                'To create tasks',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 12),

              // Body text
              Text(
                'Please subscribe first. Visit our subscription page to continue. Start Free Trial 7 days. Thank you!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 16,
                  color: AppColors.grey,
                ),
              ),
              const SizedBox(height: 32),

              // Yes Button
              ElevatedButton(
                onPressed: () {
                  Get.to(SubscriptionPage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5C9FFB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Yes',style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',

                ),),
              ),
            ],
          ),
        ),
      );
    },
  );
}