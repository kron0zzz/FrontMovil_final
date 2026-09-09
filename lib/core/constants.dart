import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFFD97706);
  static const primaryLight = Color(0xFFF59E0B);
  static const accent = Color(0xFFEA580C);
  static const accentSoft = Color(0xFFFFEDD5);
  static const background = Color(0xFFFAFAF9);
  static const card = Color(0xFFFFFFFF);
  static const text = Color(0xFF1C1917);
  static const textLight = Color(0xFF78716C);
  static const border = Color(0xFFE7E5E4);
}

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.primaryLight,
        surface: AppColors.background,
        onSurface: AppColors.text,
      ),
      scaffoldBackgroundColor: AppColors.background,
      cardColor: AppColors.card,
      fontFamily: 'Roboto',
    );
  }
}

/// URL base de la API - Única fuente de verdad
const String apiBaseUrl = 'http://localhost:3000/api';
