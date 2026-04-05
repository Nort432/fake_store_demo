import 'package:flutter/material.dart';

import '../../../../../core/theme/app_palette.dart';

class QtyButton extends StatelessWidget {
  const QtyButton({required this.icon, required this.onTap, super.key});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: context.appPalette.surfaceCard,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: context.appPalette.borderSubtle),
        ),
        child: Icon(icon, size: 14, color: context.appPalette.textPrimary),
      ),
    );
  }
}
