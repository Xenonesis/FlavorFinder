import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF6366F1); // Modern indigo
  static const Color secondaryColor = Color(0xFF8B5CF6); // Modern purple
  static const Color backgroundColor = Color(0xFFFAFAFC); // Ultra-clean background
  static const Color surfaceColor = Color(0xFFFFFFFF); // Pure white
  static const Color errorColor = Color(0xFFEF4444); // Modern red
  static const Color successColor = Color(0xFF10B981); // Modern green
  static const Color textPrimary = Color(0xFF0F172A); // Rich dark
  static const Color textSecondary = Color(0xFF64748B); // Modern slate
  static const Color borderColor = Color(0xFFE2E8F0); // Light slate border
  static const Color darkBackgroundColor = Color(0xFF0F172A); // Deep slate
  static const Color darkSurfaceColor = Color(0xFF1E293B); // Dark slate surface
  static const Color darkTextPrimary = Color(0xFFF1F5F9); // Almost white
  static const Color darkTextSecondary = Color(0xFFCBD5E1); // Light slate
  static const Color darkBorderColor = Color(0xFF404040);

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: MaterialColor(primaryColor.value, {
        50: const Color(0xFFFFF3F0),
        100: const Color(0xFFFFE6DF),
        200: const Color(0xFFFFCCBF),
        300: const Color(0xFFFFB39F),
        400: const Color(0xFFFF997F),
        500: primaryColor,
        600: const Color(0xFFE6612F),
        700: const Color(0xFFCC5629),
        800: const Color(0xFFB34A23),
        900: const Color(0xFF99401D),
      }),
      scaffoldBackgroundColor: backgroundColor,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          inherit: false,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          letterSpacing: 0.1,
        ),
        displayMedium: TextStyle(
          inherit: false,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          letterSpacing: 0.1,
        ),
        headlineLarge: TextStyle(
          inherit: false,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: 0.1,
        ),
        headlineMedium: TextStyle(
          inherit: false,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: 0.1,
        ),
        titleLarge: TextStyle(
          inherit: false,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: textPrimary,
          letterSpacing: 0.1,
        ),
        bodyLarge: TextStyle(
          inherit: false,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: textPrimary,
          letterSpacing: 0.1,
        ),
        bodyMedium: TextStyle(
          inherit: false,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: textSecondary,
          letterSpacing: 0.1,
        ),
        bodySmall: TextStyle(
          inherit: false,
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: textSecondary,
          letterSpacing: 0.1,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            inherit: false,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            inherit: false,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceColor,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          inherit: false,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: MaterialColor(primaryColor.value, {
        50: const Color(0xFFFFF3F0),
        100: const Color(0xFFFFE6DF),
        200: const Color(0xFFFFCCBF),
        300: const Color(0xFFFFB39F),
        400: const Color(0xFFFF997F),
        500: primaryColor,
        600: const Color(0xFFE6612F),
        700: const Color(0xFFCC5629),
        800: const Color(0xFFB34A23),
        900: const Color(0xFF99401D),
      }),
      scaffoldBackgroundColor: darkBackgroundColor,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          inherit: false,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: darkTextPrimary,
          letterSpacing: 0.1,
        ),
        displayMedium: TextStyle(
          inherit: false,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: darkTextPrimary,
          letterSpacing: 0.1,
        ),
        headlineLarge: TextStyle(
          inherit: false,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: darkTextPrimary,
          letterSpacing: 0.1,
        ),
        headlineMedium: TextStyle(
          inherit: false,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: darkTextPrimary,
          letterSpacing: 0.1,
        ),
        titleLarge: TextStyle(
          inherit: false,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: darkTextPrimary,
          letterSpacing: 0.1,
        ),
        bodyLarge: TextStyle(
          inherit: false,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: darkTextPrimary,
          letterSpacing: 0.1,
        ),
        bodyMedium: TextStyle(
          inherit: false,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: darkTextSecondary,
          letterSpacing: 0.1,
        ),
        bodySmall: TextStyle(
          inherit: false,
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: darkTextSecondary,
          letterSpacing: 0.1,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            inherit: false,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            inherit: false,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: darkSurfaceColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkSurfaceColor,
        foregroundColor: darkTextPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          inherit: false,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: darkTextPrimary,
          letterSpacing: 0.1,
        ),
      ),
    );
  }
}
