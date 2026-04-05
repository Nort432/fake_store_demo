import 'package:flutter/material.dart';

import '../constants/app_radii.dart';
import '../theme/app_palette.dart';

enum AppButtonVariant {
  darkFilled,
  lightGoldFilled,
  strongGoldFilled,
  outlinedActive,
  outlinedDisabled,
  disabledFilled,
}

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.darkFilled,
    this.small = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final style = _style(context);

    return SizedBox(
      height: small ? 40 : 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: Text(label),
      ),
    );
  }

  ButtonStyle _style(BuildContext context) {
    final palette = context.appPalette;
    final isDisabled = onPressed == null;

    Color backgroundColor;
    Color foregroundColor;
    BorderSide? border;

    switch (variant) {
      case AppButtonVariant.darkFilled:
        backgroundColor = palette.buttonDark;
        foregroundColor = Colors.white;
      case AppButtonVariant.lightGoldFilled:
        backgroundColor = palette.buttonLightGold;
        foregroundColor = palette.textPrimary;
      case AppButtonVariant.strongGoldFilled:
        backgroundColor = palette.buttonStrongGold;
        foregroundColor = Colors.white;
      case AppButtonVariant.outlinedActive:
        backgroundColor = palette.surfaceCard;
        foregroundColor = palette.textPrimary;
        border = BorderSide(color: palette.borderSubtle);
      case AppButtonVariant.outlinedDisabled:
        backgroundColor = palette.surfaceCard;
        foregroundColor = palette.navInactive;
        border = BorderSide(color: palette.borderSubtle);
      case AppButtonVariant.disabledFilled:
        backgroundColor = palette.disabledBackground;
        foregroundColor = palette.navInactive;
    }

    if (isDisabled && variant != AppButtonVariant.disabledFilled) {
      backgroundColor = palette.disabledBackground;
      foregroundColor = palette.navInactive;
    }

    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.button),
        side: border ?? BorderSide.none,
      ),
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
