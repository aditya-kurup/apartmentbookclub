import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Background Colors
  static const Color backgroundColor = Color(0xFFF8FAFC); // Light slate background
  static const Color surfaceColor = Color(0xFFFFFFFF); // Pure white for cards
  static const Color cardColor = Color(0xFFFFFFFF); // Pure white for cards
  
  // Primary Gradient Colors (Purple-Blue)
  static const Color primaryColor = Color(0xFF667eea); // Blue purple
  static const Color accentColor = Color(0xFF764ba2); // Deep purple
  static const Color gradientStart = Color(0xFF667eea); // Blue purple
  static const Color gradientEnd = Color(0xFF764ba2); // Deep purple
  
  // Text Colors
  static const Color textPrimary = Color(0xFF1e293b); // Slate 800
  static const Color textSecondary = Color(0xFF64748b); // Slate 500
  static const Color textMuted = Color(0xFF6b7280); // Gray 500
  
  // Genre-Specific Colors
  static const Color mysteryColor = Color(0xFF667eea); // Blue purple
  static const Color fictionColor = Color(0xFFf093fb); // Pink
  static const Color romanceColor = Color(0xFF4facfe); // Light blue
  static const Color scienceStartColor = Color(0xFF43e97b); // Green
  static const Color scienceEndColor = Color(0xFF38f9d7); // Cyan
  
  // Star Rating Color
  static const Color starColor = Color(0xFFfbbf24); // Amber 400
  
  // Utility Colors
  static const Color lightAccent = Color(0xFFF1F5F9); // Slate 50

  // Light theme
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        background: backgroundColor,
        surface: surfaceColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: textPrimary,
        onSurface: textPrimary,
      ),
      useMaterial3: true,
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: textPrimary,
          ),
          headlineMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
          headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textPrimary,
          ),
          titleSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textPrimary,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textPrimary,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: textSecondary,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: textSecondary,
          ),
        ),
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimary,
          side: const BorderSide(color: textSecondary),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightAccent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(
          color: textMuted,
          fontFamily: 'Poppins',
        ),
        labelStyle: TextStyle(
          color: textSecondary,
          fontFamily: 'Poppins',
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }

  static ThemeData get darkTheme => lightTheme;

  // Gradient Helpers
  static LinearGradient get primaryGradient => const LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get mysteryGradient => LinearGradient(
    colors: [mysteryColor, mysteryColor.withOpacity(0.7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get fictionGradient => LinearGradient(
    colors: [fictionColor, fictionColor.withOpacity(0.7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get romanceGradient => LinearGradient(
    colors: [romanceColor, romanceColor.withOpacity(0.7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get scienceGradient => const LinearGradient(
    colors: [scienceStartColor, scienceEndColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadow Styles
  static List<BoxShadow> get softShadow => [
    BoxShadow(
      color: textPrimary.withOpacity(0.08),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: textPrimary.withOpacity(0.06),
      blurRadius: 16,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get buttonShadow => [
    BoxShadow(
      color: primaryColor.withOpacity(0.25),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];
}
