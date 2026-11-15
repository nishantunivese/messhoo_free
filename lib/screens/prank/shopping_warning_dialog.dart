import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class ShoppingWarningDialog extends StatelessWidget {
  final VoidCallback onProceed;

  const ShoppingWarningDialog({super.key, required this.onProceed});

  static void show(BuildContext context, {required VoidCallback onProceed}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ShoppingWarningDialog(onProceed: onProceed),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryPink.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Text('⚠️', style: TextStyle(fontSize: 42)),
            ),
            const SizedBox(height: 16),
            const Text(
              'FINAL WARNING, SUPRIYA!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: AppColors.primaryPinkDark,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Supriya, are you sure? Tum phir shopping karne ja rahi ho?\n\nAlmirah mein jagah bachi hai ya kapde bed par rakhne padenge? 👗🤦‍♀️',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onProceed();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPink,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  'Haan, mujhe dress chahiye! 🛍️',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: AppColors.deepPurple,
                      content: Text('😇 Jhooth mat bolo Supriya, 2 minute baad phir aaogi! 😂'),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.deepPurple,
                  side: const BorderSide(color: AppColors.deepPurple),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  'Nahi, main sudhar gayi! 😇',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
