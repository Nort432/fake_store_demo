import 'package:flutter/material.dart';

@immutable
class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({
    required this.screenTitle,
    required this.headerGreeting,
    required this.logoutLabel,
    required this.productTitle,
    required this.productSubtitle,
    required this.productMeta,
    required this.productPrice,
    required this.navLabel,
    required this.priceAccent,
  });

  final TextStyle screenTitle;
  final TextStyle headerGreeting;
  final TextStyle logoutLabel;
  final TextStyle productTitle;
  final TextStyle productSubtitle;
  final TextStyle productMeta;
  final TextStyle productPrice;
  final TextStyle navLabel;
  final TextStyle priceAccent;

  @override
  AppTypography copyWith({
    TextStyle? screenTitle,
    TextStyle? headerGreeting,
    TextStyle? logoutLabel,
    TextStyle? productTitle,
    TextStyle? productSubtitle,
    TextStyle? productMeta,
    TextStyle? productPrice,
    TextStyle? navLabel,
    TextStyle? priceAccent,
  }) {
    return AppTypography(
      screenTitle: screenTitle ?? this.screenTitle,
      headerGreeting: headerGreeting ?? this.headerGreeting,
      logoutLabel: logoutLabel ?? this.logoutLabel,
      productTitle: productTitle ?? this.productTitle,
      productSubtitle: productSubtitle ?? this.productSubtitle,
      productMeta: productMeta ?? this.productMeta,
      productPrice: productPrice ?? this.productPrice,
      navLabel: navLabel ?? this.navLabel,
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
      headerGreeting:
          TextStyle.lerp(headerGreeting, other.headerGreeting, t) ??
          headerGreeting,
      logoutLabel:
          TextStyle.lerp(logoutLabel, other.logoutLabel, t) ?? logoutLabel,
      productTitle:
          TextStyle.lerp(productTitle, other.productTitle, t) ?? productTitle,
      productSubtitle:
          TextStyle.lerp(productSubtitle, other.productSubtitle, t) ??
          productSubtitle,
      productMeta:
          TextStyle.lerp(productMeta, other.productMeta, t) ?? productMeta,
      productPrice:
          TextStyle.lerp(productPrice, other.productPrice, t) ?? productPrice,
      navLabel: TextStyle.lerp(navLabel, other.navLabel, t) ?? navLabel,
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
