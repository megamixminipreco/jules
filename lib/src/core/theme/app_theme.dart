import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Cores do Gradiente Roxo
  static const Color primaryPurple = Color(0xFF2E1065); // Roxo mais escuro
  static const Color secondaryPurple = Color(0xFF4C1D95); // Roxo mais claro

  // Dourado para destaques
  static const Color gold = Color(0xFFFACC15);

  // Cores de Texto
  static const Color textWhite = Color(0xFFF1F5F9);
  static const Color textGold = Color(0xFFFACC15);

  // Outras cores
  static const Color translucent = Colors.white10; // 10% de opacidade
  static const Color errorRed = Color(0xFF991B1B);
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.primaryPurple,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.secondaryPurple,
        onPrimary: AppColors.textWhite,
        secondary: AppColors.gold,
        onSecondary: AppColors.primaryPurple,
        error: AppColors.errorRed,
        onError: AppColors.textWhite,
        background: AppColors.primaryPurple,
        onBackground: AppColors.textWhite,
        surface: AppColors.secondaryPurple,
        onSurface: AppColors.textWhite,
      ),
      textTheme: GoogleFonts.cormorantGaramondTextTheme(
        ThemeData.dark().textTheme.copyWith(
              // Título Grande (Ex: PORTAL 369)
              displayMedium: const TextStyle(
                color: AppColors.textGold,
                fontWeight: FontWeight.bold,
              ),
              // Título de Seção (Ex: Ative seu portal...)
              headlineSmall: const TextStyle(
                color: AppColors.textWhite,
              ),
              // Corpo de texto padrão
              bodyMedium: const TextStyle(
                color: AppColors.textWhite,
                fontSize: 16,
              ),
              // Texto de Botão
              labelLarge: const TextStyle(
                color: AppColors.textWhite,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.primaryPurple,
          backgroundColor: AppColors.gold,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.translucent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        labelStyle: const TextStyle(color: AppColors.textWhite),
      ),
    );
  }
}
