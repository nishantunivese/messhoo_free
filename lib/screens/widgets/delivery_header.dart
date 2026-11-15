import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class DeliveryHeader extends StatelessWidget {
  const DeliveryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.location_on_rounded, color: AppColors.primaryPink, size: 20),
          const SizedBox(width: 8),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Deliver to Supriya ',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.textPrimary),
                    ),
                    Text(
                      '- Almirah No. 1, Dream House',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                    ),
                  ],
                ),
                Text(
                  'Wardrobe Capacity: 150% Overloaded 👗',
                  style: TextStyle(fontSize: 11, color: AppColors.primaryPink, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary, size: 20),
        ],
      ),
    );
  }
}
