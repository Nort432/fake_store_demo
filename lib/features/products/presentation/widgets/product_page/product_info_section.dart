import 'package:flutter/material.dart';

import '../../../../../core/theme/app_palette.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../domain/entities/product.dart';

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: context.appPalette.surfaceCard,
      constraints: const BoxConstraints(minHeight: 158),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.title, style: context.appTypography.screenTitle),
              const SizedBox(height: 6),
              Text(
                product.subtitle,
                style: context.appTypography.productSubtitle,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.star_rounded,
                size: 16,
                color: context.appPalette.star,
              ),
              const SizedBox(width: 4),
              Text(
                product.rating.toStringAsFixed(2),
                style: context.appTypography.productMeta,
              ),
              const SizedBox(width: 6),
              Text('12 Reviews', style: context.appTypography.productSubtitle),
            ],
          ),
        ],
      ),
    );
  }
}
