import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class CategoryChipList extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onSelected;

  const CategoryChipList({
    super.key,
    required this.selectedCategory,
    required this.onSelected,
  });

  static const List<Map<String, String>> categories = [
    {'name': 'All', 'icon': '✨'},
    {'name': 'Dresses', 'icon': '👗'},
    {'name': 'Saree', 'icon': '🥻'},
    {'name': 'Kurti', 'icon': '👘'},
    {'name': 'Western Wear', 'icon': '🧥'},
    {'name': 'Party Wear', 'icon': '💃'},
    {'name': 'Tops', 'icon': '👚'},
    {'name': 'Jeans', 'icon': '👖'},
    {'name': 'Ethnic Wear', 'icon': '🪡'},
    {'name': 'Co-ord Sets', 'icon': '👯‍♀️'},
    {'name': 'Casual Outfits', 'icon': '👟'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: categories.length,
        itemBuilder: (ctx, i) {
          final cat = categories[i];
          final isSelected = selectedCategory.toLowerCase() == cat['name']!.toLowerCase();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(cat['icon']!, style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 5),
                  Text(
                    cat['name']!,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                      fontSize: 12.5,
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              selected: isSelected,
              selectedColor: AppColors.primaryPink,
              backgroundColor: Colors.white,
              elevation: isSelected ? 2 : 0,
              side: BorderSide(
                color: isSelected ? AppColors.primaryPink : AppColors.border,
                width: 0.8,
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              onSelected: (val) => onSelected(cat['name']!),
            ),
          );
        },
      ),
    );
  }
}
