import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_colors.dart';
import '../providers/cart_provider.dart';
import 'prank/fake_checkout_screen.dart';
import 'prank/shopping_warning_dialog.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Shopping Cart (${cart.totalQuantity} Items)',
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
        ),
      ),
      body: cart.items.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🛍️', style: TextStyle(fontSize: 60)),
                  const SizedBox(height: 12),
                  const Text(
                    'Your Cart is Empty!',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
                  ),
                  const SizedBox(height: 6),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'Supriya! ₹0 ke dresses dekh kar bhi cart khali? Yeh toh chamatkaar ho gaya! 😂',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: AppColors.textMuted),
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  // Cart Items List
                  ...cart.items.map((item) {
                    final p = item.product;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              p.imageUrl,
                              width: 70,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  p.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Size: ${item.selectedSize} • ${p.category}',
                                  style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Text(
                                      '₹0',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.freeGreen,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '₹${p.originalPrice}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        decoration: TextDecoration.lineThrough,
                                        color: AppColors.textMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Quantity Controls
                          Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle_outline, size: 20),
                                    onPressed: () => ref
                                        .read(cartProvider.notifier)
                                        .updateQuantity(p.id, item.selectedSize, item.quantity - 1),
                                  ),
                                  Text(
                                    item.quantity.toString(),
                                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_outline, size: 20, color: AppColors.primaryPink),
                                    onPressed: () => ref
                                        .read(cartProvider.notifier)
                                        .updateQuantity(p.id, item.selectedSize, item.quantity + 1),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 10),

                  // Bill Details Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Price Details',
                          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                        ),
                        const Divider(height: 20),
                        _buildBillRow('Total MRP', '₹${cart.originalTotalPrice}'),
                        const SizedBox(height: 8),
                        _buildBillRow('Messhoo Free Discount', '-₹${cart.originalTotalPrice}', isDiscount: true),
                        const SizedBox(height: 8),
                        _buildBillRow('Delivery Fee', 'FREE', isDiscount: true),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Amount Payable',
                              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                            ),
                            const Text(
                              '₹0',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                color: AppColors.freeGreen,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Funny Savings Notice
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.freeGreenLight,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.freeGreen.withOpacity(0.4)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.savings_outlined, color: AppColors.freeGreen),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Supriya Special: You saved ₹${cart.originalTotalPrice} and lost 100% Almirah space! 😂',
                            style: const TextStyle(
                              color: AppColors.freeGreen,
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
      bottomNavigationBar: cart.items.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: AppColors.border)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -2)),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total: ₹0', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.freeGreen)),
                        Text('100% OFF for Supriya', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        final firstProduct = cart.items.first.product;
                        ShoppingWarningDialog.show(
                          context,
                          onProceed: () => FakeCheckoutScreen.start(context, firstProduct),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryPink,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        'PLACE ₹0 ORDER 🛍️',
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13.5, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildBillRow(String label, String value, {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: isDiscount ? AppColors.freeGreen : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
