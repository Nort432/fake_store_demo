import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_radii.dart';

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
    final style = _style();

    return SizedBox(
      height: small ? 40 : 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: Text(label),
      ),
    );
  }

  ButtonStyle _style() {
    final isDisabled = onPressed == null;

    Color backgroundColor;
    Color foregroundColor;
    BorderSide? border;

    switch (variant) {
      case AppButtonVariant.darkFilled:
        backgroundColor = AppColors.darkButton;
        foregroundColor = Colors.white;
      case AppButtonVariant.lightGoldFilled:
        backgroundColor = AppColors.primaryLightGold;
        foregroundColor = AppColors.darkText;
      case AppButtonVariant.strongGoldFilled:
        backgroundColor = AppColors.primaryStrongGold;
        foregroundColor = Colors.white;
      case AppButtonVariant.outlinedActive:
        backgroundColor = Colors.white;
        foregroundColor = AppColors.darkText;
        border = const BorderSide(color: AppColors.inputBorder);
      case AppButtonVariant.outlinedDisabled:
        backgroundColor = Colors.white;
        foregroundColor = AppColors.inactiveIconGray;
        border = const BorderSide(color: AppColors.inputBorder);
      case AppButtonVariant.disabledFilled:
        backgroundColor = AppColors.disabledBackground;
        foregroundColor = AppColors.inactiveIconGray;
    }

    if (isDisabled && variant != AppButtonVariant.disabledFilled) {
      backgroundColor = AppColors.disabledBackground;
      foregroundColor = AppColors.inactiveIconGray;
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
