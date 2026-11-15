import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../services/prank_service.dart';

class ShoppingQueenDialog extends StatelessWidget {
  final int count;

  const ShoppingQueenDialog({super.key, required this.count});

  static void show(BuildContext context, int count) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ShoppingQueenDialog(count: count),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: const Color(0xFFFFD700), width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.amber.withOpacity(0.4),
              blurRadius: 35,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Golden Crown Animation
              const Text('👑', style: TextStyle(fontSize: 72))
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scale(duration: 400.ms, begin: const Offset(0.9, 0.9), end: const Offset(1.2, 1.2))
                  .rotate(duration: 400.ms, begin: -0.06, end: 0.06),

              const SizedBox(height: 12),

              // Title
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: AppColors.goldenQueenGradient,
                ).createShader(bounds),
                child: const Text(
                  'CROWN UNLOCKED!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Personalized Headline
              const Text(
                'Congratulations Supriya!\nTum Messhoo Free ki Official Shopping Queen ban chuki ho! 👑🛍️',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.deepPurple,
                  height: 1.35,
                ),
              ),

              const SizedBox(height: 16),

              // Certificate Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9C4), // Golden yellow tint
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFFFD54F), width: 1.5),
                ),
                child: Column(
                  children: [
                    const Text(
                      '📜 OFFICIAL SHOPPING PRANK CERTIFICATE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFF57F17),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Total Attempted Orders: $count Dresses\n'
                      'Total Money Spent: ₹0\n'
                      'Total Wardrobe Space Remaining: -200%\n'
                      'Status: Non-Stop Fashion Addict!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Share Queen Certificate
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    PrankService.instance.shareRoast(
                      '👑 Congratulations Supriya! Tum Messhoo Free ki Official Shopping Queen ban chuki ho! Total $count dresses attempt kiye bina kisi control ke! 😂🛍️',
                    );
                  },
                  icon: const Icon(Icons.share, color: Colors.white, size: 18),
                  label: const Text(
                    'Share Crown with Supriya 👑',
                    style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white, fontSize: 13),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE91E63),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Back to shopping
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.deepPurple,
                    side: const BorderSide(color: AppColors.deepPurple),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    'Order Aur Bhi Dresses! 😂',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
