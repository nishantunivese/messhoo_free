import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_colors.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';
import 'widgets/product_card.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistProvider);
    final allProducts = ref.watch(productProvider).allProducts;

    final wishlistedProducts = allProducts.where((p) => wishlist.contains(p.id)).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Supriya\'s Wishlist (${wishlistedProducts.length})',
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
        ),
      ),
      body: wishlistedProducts.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('❤️', style: TextStyle(fontSize: 54)),
                  const SizedBox(height: 12),
                  const Text(
                    'Your Wishlist is Empty, Supriya!',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Dresses dekhne ke baad wishlist na karna tumhari fitrat nahi! 😂',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.5, color: AppColors.textMuted),
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                childAspectRatio: 0.54,
              ),
              itemCount: wishlistedProducts.length,
              itemBuilder: (ctx, i) => ProductCard(product: wishlistedProducts[i]),
            ),
    );
  }
}
