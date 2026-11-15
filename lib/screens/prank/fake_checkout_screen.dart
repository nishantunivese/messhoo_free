import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../services/prank_service.dart';
import 'roast_popup_dialog.dart';
import 'shopping_queen_dialog.dart';

class FakeCheckoutScreen extends ConsumerStatefulWidget {
  final Product product;

  const FakeCheckoutScreen({super.key, required this.product});

  static void start(BuildContext context, Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FakeCheckoutScreen(product: product),
      ),
    );
  }

  @override
  ConsumerState<FakeCheckoutScreen> createState() => _FakeCheckoutScreenState();
}

class _FakeCheckoutScreenState extends ConsumerState<FakeCheckoutScreen> {
  int _currentStep = 0;

  final _steps = [
    'Connecting to Supriya\'s Dream Almirah...',
    'Checking wardrobe free space... (RESULT: 0% Space Left!)',
    'Order processing... Supriya ki shopping addiction verify ho rahi hai! 📦🚚',
  ];

  @override
  void initState() {
    super.initState();
    _startPrankSequence();
  }

  void _startPrankSequence() async {
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _currentStep = 1);

    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() => _currentStep = 2);

    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;

    // Increment Roast Count
    final count = await PrankService.instance.incrementRoastCount();
    ref.read(roastProvider.notifier).increment();

    // Play buzzer/vibration sound
    PrankService.instance.playPrankBuzzer();

    Navigator.of(context).pop(); // Exit fake checkout

    // Milestone check: every 5 roasts, show Special Shopping Queen celebration!
    if (count == 5 || count == 10) {
      ShoppingQueenDialog.show(context, count);
    } else {
      RoastPopupDialog.show(context, count);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Securing ₹0 Order...'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Product Preview Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.product.imageUrl,
                  width: 140,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 140,
                    height: 180,
                    color: AppColors.purpleLight,
                    child: const Icon(Icons.checkroom, color: AppColors.primaryPink, size: 50),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.product.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '₹0',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: AppColors.freeGreen,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '₹${widget.product.originalPrice}',
                    style: const TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.lineThrough,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.discountBadge,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      '100% OFF FREE',
                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 36),

              // Animated Delivery Box Icon
              const Text('📦', style: TextStyle(fontSize: 54))
                  .animate(onPlay: (controller) => controller.repeat(reverse: true))
                  .scale(duration: 500.ms, begin: const Offset(0.9, 0.9), end: const Offset(1.15, 1.15)),

              const SizedBox(height: 24),

              // Progress bar
              const SizedBox(
                width: 200,
                child: LinearProgressIndicator(
                  color: AppColors.primaryPink,
                  backgroundColor: AppColors.primaryPinkLight,
                ),
              ),

              const SizedBox(height: 20),

              // Funny Progress Text
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  _steps[_currentStep],
                  key: ValueKey<int>(_currentStep),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.deepPurple,
                    height: 1.4,
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
