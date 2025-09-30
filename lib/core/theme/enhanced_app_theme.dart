import 'package:flutter/material.dart';

class EnhancedAppTheme {
  // Modern Light Theme Colors - 2025 Design Trends
  static const Color primaryColor = Color(0xFF6366F1); // Modern indigo
  static const Color primaryVariant = Color(0xFF4F46E5); // Deeper indigo
  static const Color secondaryColor = Color(0xFF8B5CF6); // Modern purple
  static const Color accentColor = Color(0xFF06B6D4); // Cyan accent
  static const Color backgroundColor = Color(0xFFFAFAFC); // Ultra-clean white
  static const Color surfaceColor = Color(0xFFFFFFFF); // Pure white
  static const Color cardColor = Color(0xFFF8FAFC); // Subtle card background
  
  // Status Colors - Modern & Vibrant
  static const Color errorColor = Color(0xFFEF4444); // Modern red
  static const Color successColor = Color(0xFF10B981); // Modern green
  static const Color warningColor = Color(0xFFF59E0B); // Modern amber
  static const Color infoColor = Color(0xFF3B82F6); // Modern blue
  
  // Text Colors - High Contrast & Modern
  static const Color textPrimary = Color(0xFF0F172A); // Rich dark slate
  static const Color textSecondary = Color(0xFF64748B); // Modern slate
  static const Color textTertiary = Color(0xFF94A3B8); // Light slate
  static const Color textLight = Color(0xFFCBD5E1); // Very light slate
  
  // Dark Theme Colors - Deep & Sophisticated
  static const Color darkPrimaryColor = Color(0xFF818CF8); // Lighter indigo for dark
  static const Color darkSecondaryColor = Color(0xFFA78BFA); // Light purple for dark
  static const Color darkBackgroundColor = Color(0xFF0F172A); // Deep slate
  static const Color darkSurfaceColor = Color(0xFF1E293B); // Dark slate surface
  static const Color darkCardColor = Color(0xFF334155); // Card background
  static const Color darkTextPrimary = Color(0xFFF1F5F9); // Almost white
  static const Color darkTextSecondary = Color(0xFFCBD5E1); // Light slate
  static const Color darkBorderColor = Color(0xFF475569); // Medium slate
  static const Color darkDividerColor = Color(0xFF374151); // Subtle divider

  // Border and Divider Colors - Modern & Subtle
  static const Color borderColor = Color(0xFFE2E8F0); // Light slate border
  static const Color dividerColor = Color(0xFFF1F5F9); // Very light divider
  
  // Gradient Colors for Modern UI
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, primaryVariant],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondaryColor, accentColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primarySwatch: _createMaterialColor(primaryColor),
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        primaryContainer: Color(0xFFEEF2FF), // Light indigo container
        secondary: secondaryColor,
        secondaryContainer: Color(0xFFF3E8FF), // Light purple container
        tertiary: accentColor,
        tertiaryContainer: Color(0xFFE0F7FA), // Light cyan container
        surface: surfaceColor,
        surfaceVariant: cardColor,
        background: backgroundColor,
        error: errorColor,
        errorContainer: Color(0xFFFEF2F2), // Light red container
        onPrimary: Colors.white,
        onPrimaryContainer: Color(0xFF312E81), // Dark indigo on container
        onSecondary: Colors.white,
        onSecondaryContainer: Color(0xFF581C87), // Dark purple on container
        onTertiary: Colors.white,
        onTertiaryContainer: Color(0xFF164E63), // Dark cyan on container
        onSurface: textPrimary,
        onSurfaceVariant: textSecondary,
        onBackground: textPrimary,
        onError: Colors.white,
        onErrorContainer: Color(0xFF991B1B), // Dark red on container
        outline: borderColor,
        outlineVariant: dividerColor,
      ),
      
      // Typography
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          letterSpacing: -0.25,
        ),
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: textPrimary,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: textSecondary,
          height: 1.4,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: textSecondary,
          height: 1.3,
        ),
      ),
      
      // Component Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: primaryColor.withOpacity(0.3),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // More rounded for modern look
          side: BorderSide(
            color: borderColor,
            width: 1,
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: 0.15,
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey[100],
        selectedColor: primaryColor.withOpacity(0.2),
        labelStyle: const TextStyle(color: textPrimary),
        secondaryLabelStyle: const TextStyle(color: primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primarySwatch: _createMaterialColor(darkPrimaryColor),
      primaryColor: darkPrimaryColor,
      scaffoldBackgroundColor: darkBackgroundColor,
      cardColor: darkCardColor,
      dividerColor: darkDividerColor,
      shadowColor: Colors.black.withOpacity(0.5),
      colorScheme: const ColorScheme.dark(
        primary: darkPrimaryColor,
        primaryContainer: Color(0xFF3730A3), // Dark indigo container
        secondary: darkSecondaryColor,
        secondaryContainer: Color(0xFF7C3AED), // Dark purple container
        tertiary: Color(0xFF06B6D4), // Cyan for dark theme
        tertiaryContainer: Color(0xFF0E7490), // Dark cyan container
        surface: darkSurfaceColor,
        surfaceVariant: darkCardColor,
        background: darkBackgroundColor,
        error: Color(0xFFF87171), // Lighter red for dark theme
        errorContainer: Color(0xFF7F1D1D), // Dark red container
        onPrimary: Color(0xFF1E1B4B), // Very dark indigo
        onPrimaryContainer: Color(0xFFE0E7FF), // Very light indigo
        onSecondary: Color(0xFF3C1A78), // Very dark purple
        onSecondaryContainer: Color(0xFFF3E8FF), // Very light purple
        onTertiary: Color(0xFF083344), // Very dark cyan
        onTertiaryContainer: Color(0xFFCFFAFE), // Very light cyan
        onSurface: darkTextPrimary,
        onSurfaceVariant: darkTextSecondary,
        onBackground: darkTextPrimary,
        onError: Color(0xFF450A0A), // Very dark red
        onErrorContainer: Color(0xFFFECACA), // Very light red
        outline: darkBorderColor,
        outlineVariant: darkDividerColor,
      ),
      
      // Typography for dark theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: darkTextPrimary,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: darkTextPrimary,
          letterSpacing: -0.25,
        ),
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: darkTextPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: darkTextPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: darkTextPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: darkTextPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: darkTextPrimary,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: darkTextSecondary,
          height: 1.4,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: darkTextSecondary,
          height: 1.3,
        ),
      ),
      
      // Component themes for dark mode
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkPrimaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: darkPrimaryColor.withOpacity(0.3),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: darkPrimaryColor,
          side: const BorderSide(color: darkPrimaryColor, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      
      cardTheme: CardThemeData(
        color: darkCardColor,
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // More rounded for modern look
          side: BorderSide(
            color: darkBorderColor,
            width: 1,
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackgroundColor,
        foregroundColor: darkTextPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: darkTextPrimary,
          letterSpacing: 0.15,
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkPrimaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      
      chipTheme: ChipThemeData(
        backgroundColor: darkSurfaceColor,
        selectedColor: darkPrimaryColor.withOpacity(0.2),
        labelStyle: const TextStyle(color: darkTextPrimary),
        secondaryLabelStyle: const TextStyle(color: darkPrimaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: darkCardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      
      iconTheme: const IconThemeData(
        color: darkTextSecondary,
      ),
      
      primaryIconTheme: const IconThemeData(
        color: darkPrimaryColor,
      ),
    );
  }

  static MaterialColor _createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}

// Keep the original AppTheme class for backward compatibility
class AppTheme {
  static const Color primaryColor = EnhancedAppTheme.primaryColor;
  static const Color secondaryColor = EnhancedAppTheme.secondaryColor;
  static const Color backgroundColor = EnhancedAppTheme.backgroundColor;
  static const Color surfaceColor = EnhancedAppTheme.surfaceColor;
  static const Color errorColor = EnhancedAppTheme.errorColor;
  static const Color successColor = EnhancedAppTheme.successColor;
  static const Color textPrimary = EnhancedAppTheme.textPrimary;
  static const Color textSecondary = EnhancedAppTheme.textSecondary;
  static const Color borderColor = EnhancedAppTheme.borderColor;

  static ThemeData get lightTheme => EnhancedAppTheme.lightTheme;
  static ThemeData get darkTheme => EnhancedAppTheme.darkTheme;
}
