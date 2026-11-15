import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_colors.dart';
import '../providers/product_provider.dart';
import 'widgets/category_chip.dart';
import 'widgets/delivery_header.dart';
import 'widgets/product_card.dart';
import 'widgets/promo_banner.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productProvider);
    final products = productState.filteredProducts;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        titleSpacing: 16,
        title: Row(
          children: [
            // Messhoo Free Logo & Brand
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: AppColors.brandGradient),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'm',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  fontFamily: 'serif',
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Messhoo Free',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 17,
                    color: AppColors.deepPurple,
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  '₹0 Shopping for Supriya 👗',
                  style: TextStyle(fontSize: 10, color: AppColors.primaryPink, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notification: New ₹0 Dresses added for Supriya!')),
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // 1. Delivery to Supriya Header
          const SliverToBoxAdapter(
            child: DeliveryHeader(),
          ),

          // 2. Search Bar
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(14, 4, 14, 12),
              child: TextField(
                onChanged: (val) => ref.read(productProvider.notifier).setSearchQuery(val),
                decoration: InputDecoration(
                  hintText: 'Search 100+ dresses, sarees, kurtis for Supriya...',
                  prefixIcon: const Icon(Icons.search, color: AppColors.primaryPink, size: 22),
                  suffixIcon: productState.searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 18),
                          onPressed: () => ref.read(productProvider.notifier).setSearchQuery(''),
                        )
                      : null,
                ),
              ),
            ),
          ),

          // 3. Promotional Banner
          const SliverToBoxAdapter(
            child: PromoBanner(),
          ),

          // 4. Categories Horizontal List
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: CategoryChipList(
                selectedCategory: productState.selectedCategory,
                onSelected: (cat) => ref.read(productProvider.notifier).setCategory(cat),
              ),
            ),
          ),

          // 5. Section Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
              child: Row(
                children: [
                  Text(
                    productState.selectedCategory == 'All'
                        ? '🔥 Trending 100 Dresses (All ₹0)'
                        : '👗 ${productState.selectedCategory} for Supriya',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${products.length} Products',
                    style: const TextStyle(fontSize: 12, color: AppColors.textMuted, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),

          // 6. Product 2-Column Grid
          if (productState.isLoading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator(color: AppColors.primaryPink)),
            )
          else if (products.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.search_off_rounded, size: 48, color: AppColors.textMuted),
                    const SizedBox(height: 10),
                    const Text('No dresses found for this search'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => ref.read(productProvider.notifier).setSearchQuery(''),
                      child: const Text('Show All 100 Dresses'),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.54,
                ),
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) => ProductCard(product: products[i]),
                  childCount: products.length,
                ),
              ),
            ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 24),
          ),
        ],
      ),
    );
  }
}
