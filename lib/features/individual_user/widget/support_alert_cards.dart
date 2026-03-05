import 'package:flutter/material.dart';

/// 1️⃣ Alert Types (call alerts by name/type)
enum SupportAlertType {
  clam,
  encouraging,
  logical,
}

/// 2️⃣ Main Alert Class (PUBLIC API)
class SupportAlertCards {
  static void show(
      BuildContext context, {
        required SupportAlertType type,
        VoidCallback? onButtonTap,
      }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _SupportAlertDialog(
        type: type,
        onButtonTap: onButtonTap,
      ),
    );
  }
}

/// 3️⃣ Internal Dialog UI
class _SupportAlertDialog extends StatelessWidget {
  final SupportAlertType type;
  final VoidCallback? onButtonTap;

  const _SupportAlertDialog({
    required this.type,
    this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    final config = _alertConfig(type);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F8FF),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag indicator
            Container(
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 20),

            ///  ==========
            /// --- gif ---
            /// ===========
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: config.backgroundColor,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  config.imagePath,
                  fit: BoxFit.contain,
                  gaplessPlayback: true, // 🔥 important for GIF
                ),
              ),
            ),


            const SizedBox(height: 24),

            // Message
            Text(
              config.message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                height: 1.2,
              ),
            ),

            const SizedBox(height: 28),

            // Action Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.thumb_up),
                label: Text(config.buttonText),
                onPressed: () {
                  Navigator.pop(context);
                  onButtonTap?.call();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6AA8FF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 4️⃣ Alert Configuration (EDIT ONLY HERE)
class _AlertConfig {
  final String message;
  final String buttonText;
  final String imagePath;
  final Color backgroundColor;

  _AlertConfig({
    required this.message,
    required this.buttonText,
    required this.imagePath,
    required this.backgroundColor,
  });
}

/// 5️⃣ Alert Content by Type
_AlertConfig _alertConfig(SupportAlertType type) {
  switch (type) {
    case SupportAlertType.clam:
      return _AlertConfig(
        message:
        "You’ve completed all your tasks for today.\nTake a moment to breathe — you did well.",
        buttonText: "Well done",
        imagePath: "assets/images/task_completed_popup.gif",
        backgroundColor: const Color(0xFF8FB6FF),
      );

    case SupportAlertType.encouraging:
      return _AlertConfig(
        message: "Please check the details and try again.",
        buttonText: "Okay",
        imagePath: "assets/images/task_completed_popup.gif",
        backgroundColor: Colors.orange.shade200,
      );

    case SupportAlertType.logical:
      return _AlertConfig(
        message: "Here is something useful for you.",
        buttonText: "Got it",
        imagePath: "assets/images/task_completed_popup.gif",
        backgroundColor: Colors.green.shade200,
      );
  }
}
