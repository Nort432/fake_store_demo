import 'package:flutter/material.dart';

@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.surfaceBase,
    required this.surfaceCard,
    required this.productCardSurface,
    required this.borderSubtle,
    required this.buttonDark,
    required this.buttonLightGold,
    required this.accentPale,
    required this.buttonStrongGold,
    required this.disabledBackground,
    required this.textPrimary,
    required this.textHeader,
    required this.textSecondary,
    required this.navActive,
    required this.navInactive,
    required this.heartActive,
    required this.star,
  });

  final Color surfaceBase;
  final Color surfaceCard;
  final Color productCardSurface;
  final Color borderSubtle;
  final Color buttonDark;
  final Color buttonLightGold;
  final Color accentPale;
  final Color buttonStrongGold;
  final Color disabledBackground;
  final Color textPrimary;
  final Color textHeader;
  final Color textSecondary;
  final Color navActive;
  final Color navInactive;
  final Color heartActive;
  final Color star;

  @override
  AppPalette copyWith({
    Color? surfaceBase,
    Color? surfaceCard,
    Color? productCardSurface,
    Color? borderSubtle,
    Color? buttonDark,
    Color? buttonLightGold,
    Color? accentPale,
    Color? buttonStrongGold,
    Color? disabledBackground,
    Color? textPrimary,
    Color? textHeader,
    Color? textSecondary,
    Color? navActive,
    Color? navInactive,
    Color? heartActive,
    Color? star,
  }) {
    return AppPalette(
      surfaceBase: surfaceBase ?? this.surfaceBase,
      surfaceCard: surfaceCard ?? this.surfaceCard,
      productCardSurface: productCardSurface ?? this.productCardSurface,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      buttonDark: buttonDark ?? this.buttonDark,
      buttonLightGold: buttonLightGold ?? this.buttonLightGold,
      accentPale: accentPale ?? this.accentPale,
      buttonStrongGold: buttonStrongGold ?? this.buttonStrongGold,
      disabledBackground: disabledBackground ?? this.disabledBackground,
      textPrimary: textPrimary ?? this.textPrimary,
      textHeader: textHeader ?? this.textHeader,
      textSecondary: textSecondary ?? this.textSecondary,
      navActive: navActive ?? this.navActive,
      navInactive: navInactive ?? this.navInactive,
      heartActive: heartActive ?? this.heartActive,
      star: star ?? this.star,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) {
      return this;
    }

    return AppPalette(
      surfaceBase: Color.lerp(surfaceBase, other.surfaceBase, t) ?? surfaceBase,
      surfaceCard: Color.lerp(surfaceCard, other.surfaceCard, t) ?? surfaceCard,
      productCardSurface:
          Color.lerp(productCardSurface, other.productCardSurface, t) ??
          productCardSurface,
      borderSubtle:
          Color.lerp(borderSubtle, other.borderSubtle, t) ?? borderSubtle,
      buttonDark: Color.lerp(buttonDark, other.buttonDark, t) ?? buttonDark,
      buttonLightGold:
          Color.lerp(buttonLightGold, other.buttonLightGold, t) ??
          buttonLightGold,
      accentPale: Color.lerp(accentPale, other.accentPale, t) ?? accentPale,
      buttonStrongGold:
          Color.lerp(buttonStrongGold, other.buttonStrongGold, t) ??
          buttonStrongGold,
      disabledBackground:
          Color.lerp(disabledBackground, other.disabledBackground, t) ??
          disabledBackground,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t) ?? textPrimary,
      textHeader: Color.lerp(textHeader, other.textHeader, t) ?? textHeader,
      textSecondary:
          Color.lerp(textSecondary, other.textSecondary, t) ?? textSecondary,
      navActive: Color.lerp(navActive, other.navActive, t) ?? navActive,
      navInactive: Color.lerp(navInactive, other.navInactive, t) ?? navInactive,
      heartActive: Color.lerp(heartActive, other.heartActive, t) ?? heartActive,
      star: Color.lerp(star, other.star, t) ?? star,
    );
  }
}

extension AppPaletteBuildContextX on BuildContext {
  AppPalette get appPalette {
    final palette = Theme.of(this).extension<AppPalette>();
    assert(palette != null, 'AppPalette is not configured in ThemeData');
    return palette!;
  }
}
