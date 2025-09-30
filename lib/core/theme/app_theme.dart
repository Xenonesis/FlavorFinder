import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFF6B35);
  static const Color secondaryColor = Color(0xFF2E3A59);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color surfaceColor = Colors.white;
  static const Color errorColor = Color(0xFFE74C3C);
  static const Color successColor = Color(0xFF27AE60);
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);
  static const Color borderColor = Color(0xFFE8E8E8);
  static const Color darkBackgroundColor = Color(0xFF1A1A1A);
  static const Color darkSurfaceColor = Color(0xFF2D2D2D);
  static const Color darkTextPrimary = Color(0xFFE0E0E0);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
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
