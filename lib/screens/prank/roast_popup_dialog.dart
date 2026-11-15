import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../services/prank_service.dart';

class RoastPopupDialog extends StatefulWidget {
  final int roastCount;

  const RoastPopupDialog({super.key, required this.roastCount});

  static void show(BuildContext context, int count) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => RoastPopupDialog(roastCount: count),
    );
  }

  @override
  State<RoastPopupDialog> createState() => _RoastPopupDialogState();
}

class _RoastPopupDialogState extends State<RoastPopupDialog> {
  late String _heading;
  late String _message;
  late String _emoji;

  @override
  void initState() {
    super.initState();
    _heading = PrankService.instance.getRandomHeading();
    _message = PrankService.instance.getRandomRoast();
    _emoji = PrankService.instance.getRandomEmoji();
  }

  void _nextRoast() {
    setState(() {
      _heading = PrankService.instance.getRandomHeading();
      _message = PrankService.instance.getRandomRoast();
      _emoji = PrankService.instance.getRandomEmoji();
    });
    PrankService.instance.playPrankBuzzer();
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
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryPink.withOpacity(0.35),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header Badge: Roast Counter
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.deepPurple.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.flash_on, color: AppColors.deepPurple, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          'Roast #${widget.roastCount} on Supriya',
                          style: const TextStyle(
                            color: AppColors.deepPurple,
                            fontWeight: FontWeight.w800,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.textMuted),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Bouncing Animated Emoji
              Text(_emoji, style: const TextStyle(fontSize: 68))
                  .animate(onPlay: (controller) => controller.repeat(reverse: true))
                  .scale(duration: 400.ms, begin: const Offset(0.85, 0.85), end: const Offset(1.2, 1.2))
                  .rotate(duration: 400.ms, begin: -0.05, end: 0.05),

              const SizedBox(height: 14),

              // Large Roast Heading
              Text(
                _heading,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primaryPinkDark,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 14),

              // Personalized Supriya Roast Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryPink.withOpacity(0.08),
                      AppColors.deepPurple.withOpacity(0.08),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryPink.withOpacity(0.3)),
                ),
                child: Text(
                  _message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    height: 1.45,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Free Prank Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.freeGreenLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.freeGreen.withOpacity(0.5)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle_outline, color: AppColors.freeGreen, size: 16),
                    SizedBox(width: 6),
                    Text(
                      'Messhoo Free • Official Supriya Prank Edition',
                      style: TextStyle(
                        color: AppColors.freeGreen,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Action Buttons
              // 1. Share Roast with Friends
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => PrankService.instance.shareRoast(_message),
                  icon: const Icon(Icons.share_rounded, size: 18, color: Colors.white),
                  label: const Text(
                    'Share Roast on WhatsApp 😂',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF25D366), // WhatsApp Green
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // 2. Try Another Dress (Next Roast)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _nextRoast,
                  icon: const Icon(Icons.refresh_rounded, size: 18, color: Colors.white),
                  label: const Text(
                    'Try Another Dress (More Roasts!) 👗',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // 3. Back to Shopping
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textPrimary,
                    side: const BorderSide(color: AppColors.border),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    'Back to Shopping 🛍️',
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
