import 'package:flutter/material.dart';

import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/widgets/app_button.dart';

class WishlistEmptySection extends StatelessWidget {
  const WishlistEmptySection({required this.onGoHome, super.key});

  final VoidCallback onGoHome;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Wishlist is empty', style: context.appTypography.screenTitle),
            const SizedBox(height: 8),
            Text(
              'Save products with the heart icon to see them here.',
              textAlign: TextAlign.center,
              style: context.appTypography.productSubtitle,
            ),
            const SizedBox(height: 16),
            AppButton(label: 'Browse products', onPressed: onGoHome),
          ],
        ),
      ),
    );
  }
}
