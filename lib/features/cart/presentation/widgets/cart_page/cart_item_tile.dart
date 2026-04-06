import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_palette.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../cubit/cart_cubit.dart';
import 'quantity_stepper.dart';

class CartItemTile extends StatefulWidget {
  const CartItemTile({required this.item, super.key});

  final CartItem item;

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  static const double _actionWidth = 104;
  static const double _openThreshold = 44;
  double _reveal = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: _DeleteActionButton(
                  width: _actionWidth,
                  onTap: () => context.read<CartCubit>().remove(widget.item.id),
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              curve: Curves.easeOut,
              transform: Matrix4.translationValues(-_reveal, 0, 0),
              child: _CartItemContent(item: widget.item),
            ),
          ],
        ),
      ),
    );
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final nextReveal = (_reveal - details.delta.dx).clamp(0.0, _actionWidth);
    if (nextReveal == _reveal) {
      return;
    }

    setState(() {
      _reveal = nextReveal;
    });
  }

  void _onDragEnd(DragEndDetails details) {
    final shouldOpen = _reveal >= _openThreshold;
    setState(() {
      _reveal = shouldOpen ? _actionWidth : 0;
    });
  }
}

class _DeleteActionButton extends StatelessWidget {
  const _DeleteActionButton({required this.width, required this.onTap});

  final double width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 78,
      child: Material(
        color: context.appPalette.heartActive,
        child: InkWell(
          onTap: onTap,
          child: Icon(
            Icons.delete_outline,
            color: context.appPalette.surfaceCard,
            size: 24,
          ),
        ),
      ),
    );
  }
}

class _CartItemContent extends StatelessWidget {
  const _CartItemContent({required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.appPalette.surfaceCard,
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
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
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        _normalizeText(item.title),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.appTypography.productTitle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '\$${item.total.toStringAsFixed(2)}',
                      style: context.appTypography.productPrice,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                QuantityStepper(
                  quantity: item.quantity,
                  onIncrement: () =>
                      context.read<CartCubit>().increment(item.id),
                  onDecrement: () =>
                      context.read<CartCubit>().decrement(item.id),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  String _normalizeText(String raw) {
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
