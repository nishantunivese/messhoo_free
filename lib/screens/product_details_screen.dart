import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_colors.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import 'prank/fake_checkout_screen.dart';
import 'prank/shopping_warning_dialog.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  ConsumerState<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  String _selectedSize = 'M';

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final wishlist = ref.watch(wishlistProvider);
    final isWishlisted = wishlist.contains(p.id);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(p.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
            icon: Icon(
              isWishlisted ? Icons.favorite : Icons.favorite_border,
              color: isWishlisted ? AppColors.primaryPink : AppColors.textPrimary,
            ),
            onPressed: () => ref.read(wishlistProvider.notifier).toggleWishlist(p.id),
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sharing dress deal for Supriya...')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Large Product Image
            AspectRatio(
              aspectRatio: 1.0,
              child: Image.network(
                p.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.purpleLight,
                  child: const Center(
                    child: Icon(Icons.checkroom, color: AppColors.primaryPink, size: 80),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category & Rating
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.deepPurple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          p.category.toUpperCase(),
                          style: const TextStyle(
                            color: AppColors.deepPurple,
                            fontWeight: FontWeight.w800,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.green[300]!),
                        ),
                        child: Row(
                          children: [
                            Text(
                              p.rating.toString(),
                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: Colors.green),
                            ),
                            const SizedBox(width: 3),
                            const Icon(Icons.star, color: Colors.green, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              '(${p.reviewsCount} Ratings)',
                              style: TextStyle(fontSize: 11, color: Colors.green[800]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Product Title
                  Text(
                    p.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                  ),

                  const SizedBox(height: 12),

                  // Pricing Section
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const Text(
                        '₹0',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: AppColors.freeGreen,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '₹${p.originalPrice}',
                        style: const TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.lineThrough,
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.discountBadge,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          '100% OFF FREE',
                          style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),
                  const Text(
                    'Inclusive of all taxes • Specially reserved for Supriya',
                    style: TextStyle(fontSize: 11.5, color: AppColors.textMuted),
                  ),

                  const Divider(height: 32),

                  // Select Size Section
                  const Text(
                    'Select Size',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: p.availableSizes.map((size) {
                      final isSelected = _selectedSize == size;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedSize = size),
                        child: Container(
                          width: 48,
                          height: 44,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primaryPink : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected ? AppColors.primaryPink : AppColors.border,
                              width: 1.2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              size,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 13,
                                color: isSelected ? Colors.white : AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const Divider(height: 32),

                  // Delivery Info Card
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceMuted,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.local_shipping_outlined, color: AppColors.deepPurple, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              p.deliveryTime,
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.replay_rounded, color: AppColors.deepPurple, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              p.returnPolicy,
                              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Description
                  const Text(
                    'Product Description',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    p.description,
                    style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.border, width: 0.8)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -2)),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Add to Cart
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ref.read(cartProvider.notifier).addToCart(p, _selectedSize);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.deepPurple,
                        content: Text('👗 Added ${p.name} ($size) to Cart! Almirah filling up! 😂'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_shopping_cart, size: 18),
                  label: const Text('Add to Cart', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.deepPurple,
                    side: const BorderSide(color: AppColors.deepPurple, width: 1.2),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Buy Now (Triggers Prank Sequence!)
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ShoppingWarningDialog.show(
                      context,
                      onProceed: () => FakeCheckoutScreen.start(context, p),
                    );
                  },
                  icon: const Icon(Icons.bolt_rounded, size: 20, color: Colors.white),
                  label: const Text(
                    'BUY NOW ₹0',
                    style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 13.5),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPink,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get size => _selectedSize;
}
