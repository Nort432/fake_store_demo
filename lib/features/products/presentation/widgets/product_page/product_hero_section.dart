import 'package:flutter/material.dart';

import '../../../../../core/theme/app_palette.dart';

class ProductHeroSection extends StatelessWidget {
  const ProductHeroSection({
    required this.imageUrl,
    required this.isFavorite,
    required this.onBack,
    required this.onFavoriteTap,
    super.key,
  });

  final String imageUrl;
  final bool isFavorite;
  final VoidCallback onBack;
  final VoidCallback onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: context.appPalette.surfaceBase,
      child: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: onBack,
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: onFavoriteTap,
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite
                          ? context.appPalette.heartActive
                          : context.appPalette.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
              child: imageUrl.isEmpty
                  ? const Icon(Icons.image_not_supported_outlined)
                  : Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image_outlined);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
