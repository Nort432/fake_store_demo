import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_palette.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../../products/domain/entities/product.dart';

class WishlistItemCard extends StatelessWidget {
  const WishlistItemCard({
    required this.product,
    required this.onFavoriteTap,
    super.key,
  });

  final Product product;
  final VoidCallback onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appPalette.productCardSurface,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProductImage(imageUrl: product.imageUrl),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        _normalizeTitle(product.title),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.appTypography.productTitle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: onFavoriteTap,
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Icon(
                          Icons.favorite,
                          color: context.appPalette.heartActive,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: context.appTypography.productPrice,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 36,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: context.appPalette.surfaceCard,
                      foregroundColor: context.appPalette.textPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      context.read<CartCubit>().addProduct(product);
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(content: Text('Added to cart')),
                        );
                    },
                    child: const Text('Add to cart'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _normalizeTitle(String raw) {
    final text = raw.trim();
    if (text.isEmpty) {
      return '---';
    }

    final lowered = text.toLowerCase();
    if (lowered.contains('<script') || lowered.contains('</script')) {
      return '---';
    }

    return text;
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: context.appPalette.surfaceCard,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: imageUrl.isEmpty
            ? const Icon(Icons.image_not_supported_outlined)
            : Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image_outlined);
                },
              ),
      ),
    );
  }
}
