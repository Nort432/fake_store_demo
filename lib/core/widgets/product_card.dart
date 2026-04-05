import 'package:flutter/material.dart';

import '../constants/app_radii.dart';
import '../theme/app_palette.dart';
import '../theme/app_typography.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.rating,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.onTap,
    super.key,
  });

  final String imageUrl;
  final String title;
  final String subtitle;
  final double price;
  final double rating;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: context.appPalette.productCardSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.productCard),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.productCard),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: context.appPalette.surfaceCard,
                  borderRadius: BorderRadius.circular(AppRadii.smallImage),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadii.smallImage),
                  child: Center(
                    child: imageUrl.isEmpty
                        ? const Icon(Icons.image_not_supported_outlined)
                        : Image.network(
                            imageUrl,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image_outlined);
                            },
                          ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.appTypography.productTitle,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.appTypography.productSubtitle,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                size: 14,
                                color: context.appPalette.textHeader,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                rating.toStringAsFixed(1),
                                style: context.appTypography.productMeta,
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '\$${price.toStringAsFixed(2)}',
                            style: context.appTypography.productPrice,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: onFavoriteTap,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints.tightFor(
                        width: 28,
                        height: 28,
                      ),
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        size: 22,
                        color: isFavorite
                            ? context.appPalette.heartActive
                            : context.appPalette.navInactive,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
