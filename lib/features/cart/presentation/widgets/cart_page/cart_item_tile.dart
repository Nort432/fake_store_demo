import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_palette.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../cubit/cart_cubit.dart';
import 'qty_button.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({required this.item, super.key});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appPalette.productCardSurface,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: context.appPalette.surfaceCard,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: item.imageUrl.isEmpty
                  ? const Icon(Icons.image_not_supported_outlined)
                  : Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image_outlined);
                      },
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.appTypography.productTitle,
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.appTypography.productSubtitle,
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${item.total.toStringAsFixed(2)}',
                  style: context.appTypography.productPrice,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              QtyButton(
                icon: Icons.add,
                onTap: () => context.read<CartCubit>().increment(item.id),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  '${item.quantity}',
                  style: context.appTypography.productMeta,
                ),
              ),
              QtyButton(
                icon: Icons.remove,
                onTap: () => context.read<CartCubit>().decrement(item.id),
              ),
            ],
          ),
          IconButton(
            onPressed: () => context.read<CartCubit>().remove(item.id),
            icon: Icon(Icons.close, color: context.appPalette.textSecondary),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
