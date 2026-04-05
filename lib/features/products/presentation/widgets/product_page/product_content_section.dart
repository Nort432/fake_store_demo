import 'package:flutter/material.dart';

import '../../../domain/entities/product.dart';
import 'product_bottom_bar_section.dart';
import 'product_hero_section.dart';
import 'product_info_section.dart';

class ProductContentSection extends StatelessWidget {
  const ProductContentSection({
    required this.product,
    required this.isFavorite,
    required this.onBack,
    required this.onFavoriteTap,
    required this.onAddToCart,
    super.key,
  });

  final Product product;
  final bool isFavorite;
  final VoidCallback onBack;
  final VoidCallback onFavoriteTap;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ProductHeroSection(
            imageUrl: product.imageUrl,
            isFavorite: isFavorite,
            onBack: onBack,
            onFavoriteTap: onFavoriteTap,
          ),
        ),
        ProductInfoSection(product: product),
        ProductBottomBarSection(product: product, onAddToCart: onAddToCart),
      ],
    );
  }
}
