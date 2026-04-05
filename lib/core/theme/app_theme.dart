import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import '../constants/app_radii.dart';

abstract final class AppTheme {
  static ThemeData get light {
    final baseTheme = ThemeData.light(useMaterial3: true);

    return baseTheme.copyWith(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryStrongGold,
        secondary: AppColors.primaryLightGold,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSurface: AppColors.darkText,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.urbanist(
          color: AppColors.headerDark,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: GoogleFonts.urbanist(
          color: AppColors.headerDark,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: GoogleFonts.urbanist(
          color: AppColors.darkText,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.inter(color: AppColors.darkText),
        bodyMedium: GoogleFonts.inter(color: AppColors.metaGray),
        labelLarge: GoogleFonts.urbanist(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
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
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.button),
          ),
          backgroundColor: AppColors.darkButton,
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.urbanist(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.headerDark,
        titleTextStyle: GoogleFonts.urbanist(
          color: AppColors.headerDark,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  static TextStyle moneyStyle({Color color = AppColors.darkText}) =>
      GoogleFonts.lora(color: color, fontSize: 24, fontWeight: FontWeight.w600);
}
