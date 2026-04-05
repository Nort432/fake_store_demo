import 'package:flutter/material.dart';

@immutable
class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({required this.screenTitle, required this.priceAccent});

  final TextStyle screenTitle;
  final TextStyle priceAccent;

  @override
  AppTypography copyWith({TextStyle? screenTitle, TextStyle? priceAccent}) {
    return AppTypography(
      screenTitle: screenTitle ?? this.screenTitle,
      priceAccent: priceAccent ?? this.priceAccent,
    );
  }

  @override
  AppTypography lerp(ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) {
      return this;
    }

    return AppTypography(
      screenTitle:
          TextStyle.lerp(screenTitle, other.screenTitle, t) ?? screenTitle,
      priceAccent:
          TextStyle.lerp(priceAccent, other.priceAccent, t) ?? priceAccent,
    );
  }
}

extension AppTypographyBuildContextX on BuildContext {
  AppTypography get appTypography {
    final typography = Theme.of(this).extension<AppTypography>();
    assert(typography != null, 'AppTypography is not configured in ThemeData');
    return typography!;
  }
}
