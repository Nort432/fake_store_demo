import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'app_button.dart';

class BottomActionBar extends StatelessWidget {
  const BottomActionBar({
    required this.label,
    required this.price,
    required this.buttonLabel,
    required this.onPressed,
    super.key,
  });

  final String label;
  final String price;
  final String buttonLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Color(0xFFFFE8B2)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label),
                Text(price, style: AppTheme.moneyStyle()),
              ],
            ),
          ),
          AppButton(
            label: buttonLabel,
            onPressed: onPressed,
            variant: AppButtonVariant.darkFilled,
            small: true,
          ),
        ],
      ),
    );
  }
}
