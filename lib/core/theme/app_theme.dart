import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import '../constants/app_radii.dart';
import 'app_palette.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static ThemeData get light {
    final baseTheme = ThemeData.light(useMaterial3: true);
    final fallbackTextTheme = baseTheme.textTheme.apply(
      fontFamily: GoogleFonts.inter().fontFamily,
      bodyColor: AppColors.darkText,
      displayColor: AppColors.darkText,
    );
    final screenTitleStyle = GoogleFonts.urbanist(
      color: AppColors.darkText,
      fontWeight: FontWeight.w600,
      fontSize: 24,
      height: 1.25,
    );
    final buttonLabelStyle = GoogleFonts.urbanist(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
    final headerGreetingStyle = GoogleFonts.urbanist(
      color: AppColors.headerDark,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    );
    final logoutLabelStyle = GoogleFonts.urbanist(
      color: AppColors.headerDark,
      fontSize: 12,
      fontWeight: FontWeight.w600,
      height: 1.25,
    );
    final productTitleStyle = GoogleFonts.urbanist(
      color: AppColors.darkText,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
    final productSubtitleStyle = GoogleFonts.inter(
      color: AppColors.metaGray,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
    final productMetaStyle = GoogleFonts.inter(
      color: AppColors.metaGray,
      fontSize: 13,
      fontWeight: FontWeight.w500,
    );
    final productPriceStyle = GoogleFonts.inter(
      color: AppColors.darkText,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
    final navLabelStyle = GoogleFonts.inter(
      color: AppColors.inactiveIconGray,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
    final appBarTitleStyle = GoogleFonts.urbanist(
      color: AppColors.headerDark,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    );
    final priceAccentStyle = GoogleFonts.lora(
      color: AppColors.darkText,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    );

    return baseTheme.copyWith(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryStrongGold,
        secondary: AppColors.primaryLightGold,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSurface: AppColors.darkText,
      ),
      textTheme: fallbackTextTheme,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.input),
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.input),
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.input),
          borderSide: const BorderSide(color: AppColors.primaryStrongGold),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.button),
          ),
          backgroundColor: AppColors.darkButton,
          foregroundColor: Colors.white,
          textStyle: buttonLabelStyle,
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.headerDark,
        titleTextStyle: appBarTitleStyle,
      ),
      extensions: <ThemeExtension<dynamic>>[
        const AppPalette(
          surfaceBase: AppColors.inputBackground,
          surfaceCard: Colors.white,
          productCardSurface: Color(0x0D000000),
          borderSubtle: AppColors.inputBorder,
          buttonDark: AppColors.darkButton,
          buttonLightGold: AppColors.primaryLightGold,
          accentPale: AppColors.accentPale,
          buttonStrongGold: AppColors.primaryStrongGold,
          disabledBackground: AppColors.disabledBackground,
          textPrimary: AppColors.darkText,
          textHeader: AppColors.headerDark,
          textSecondary: AppColors.metaGray,
          navActive: AppColors.headerDark,
          navInactive: AppColors.inactiveIconGray,
          heartActive: AppColors.activeHeartRed,
          star: AppColors.primaryStrongGold,
        ),
        AppTypography(
          screenTitle: screenTitleStyle,
          headerGreeting: headerGreetingStyle,
          logoutLabel: logoutLabelStyle,
          productTitle: productTitleStyle,
          productSubtitle: productSubtitleStyle,
          productMeta: productMetaStyle,
          productPrice: productPriceStyle,
          navLabel: navLabelStyle,
          priceAccent: priceAccentStyle,
        ),
      ],
    );
  }
}
