import 'package:flutter/material.dart';

import '../../../../../core/theme/app_palette.dart';
import '../../../../../core/theme/app_typography.dart';

class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    super.key,
  });

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: context.appPalette.surfaceCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.appPalette.borderSubtle),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepperIconButton(
            icon: Icons.remove_circle_outline,
            onTap: onDecrement,
          ),
          const SizedBox(width: 14),
          Text('$quantity', style: context.appTypography.productMeta),
          const SizedBox(width: 14),
          _StepperIconButton(
            icon: Icons.add_circle_outline,
            onTap: onIncrement,
          ),
        ],
      ),
    );
  }
}

class _StepperIconButton extends StatelessWidget {
  const _StepperIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Icon(icon, size: 22, color: context.appPalette.textPrimary),
      ),
    );
  }
}
