import 'package:flutter/material.dart';

import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/widgets/app_button.dart';

class CartEmptySection extends StatelessWidget {
  const CartEmptySection({required this.onContinueShopping, super.key});

  final VoidCallback onContinueShopping;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Your cart is empty',
              style: context.appTypography.screenTitle,
            ),
            const SizedBox(height: 8),
            Text(
              'Add products from the catalog to see them here.',
              textAlign: TextAlign.center,
              style: context.appTypography.productSubtitle,
            ),
            const SizedBox(height: 16),
            AppButton(label: 'Go shopping', onPressed: onContinueShopping),
          ],
        ),
      ),
    );
  }
}
