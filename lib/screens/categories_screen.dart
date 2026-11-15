import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_colors.dart';
import '../providers/product_provider.dart';

class CategoriesScreen extends ConsumerWidget {
  final VoidCallback onCategorySelected;

  const CategoriesScreen({super.key, required this.onCategorySelected});

  static const List<Map<String, dynamic>> categoryCards = [
    {'name': 'Dresses', 'icon': '👗', 'desc': 'Maxi, Bodycon, Floral & Party Dresses', 'count': '10 Dresses'},
    {'name': 'Saree', 'icon': '🥻', 'desc': 'Kanjivaram, Banarasi, Chiffon & Silk', 'count': '10 Sarees'},
    {'name': 'Kurti', 'icon': '👘', 'desc': 'Anarkali, Chikankari & Designer Kurtas', 'count': '10 Kurtis'},
    {'name': 'Western Wear', 'icon': '🧥', 'desc': 'Blazers, Trousers, Trench Coats & Skirts', 'count': '10 Outfits'},
    {'name': 'Party Wear', 'icon': '💃', 'desc': 'Sequins, Gowns, Jumpsuits & Velvet', 'count': '10 Outfits'},
    {'name': 'Tops', 'icon': '👚', 'desc': 'Crop Tops, Shirts, Cottagecore & Tanks', 'count': '10 Tops'},
    {'name': 'Jeans', 'icon': '👖', 'desc': 'High-Rise, Wide Leg, Mom & Flared Denim', 'count': '10 Jeans'},
    {'name': 'Ethnic Wear', 'icon': '🪡', 'desc': 'Sharara, Gharara, Lehenga & Palazzo Suits', 'count': '10 Outfits'},
    {'name': 'Co-ord Sets', 'icon': '👯‍♀️', 'desc': 'Blazer Sets, Resort Wear & 2-Piece Outfits', 'count': '10 Sets'},
    {'name': 'Casual Outfits', 'icon': '👟', 'desc': 'Dungarees, T-Shirt Dresses & Rompers', 'count': '10 Outfits'},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('All Fashion Categories', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        itemCount: categoryCards.length,
        itemBuilder: (ctx, i) {
          final cat = categoryCards[i];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border, width: 0.8),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.purpleLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(cat['icon'] as String, style: const TextStyle(fontSize: 24)),
                ),
              ),
              title: Text(
                cat['name'] as String,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.deepPurple),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 2),
                  Text(cat['desc'] as String, style: const TextStyle(fontSize: 11.5, color: AppColors.textSecondary)),
                  const SizedBox(height: 4),
                  Text(
                    '${cat['count']} • All at ₹0 for Supriya',
                    style: const TextStyle(fontSize: 11, color: AppColors.freeGreen, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.textMuted),
              onTap: () {
                ref.read(productProvider.notifier).setCategory(cat['name'] as String);
                onCategorySelected();
              },
            ),
          );
        },
      ),
    );
  }
}
