import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Traditional Indian inspired colors with modern Material 3
  static const Color saffron = Color(0xFFFF9933);
  static const Color deepSaffron = Color(0xFFE65100);
  static const Color green = Color(0xFF138808);
  static const Color navy = Color(0xFF000080);
  static const Color cream = Color(0xFFFFF8E7);

  static ThemeData light(bool largeText) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: saffron,
        brightness: Brightness.light,
        primary: deepSaffron,
        secondary: green,
        surface: cream,
      ),
    );

    return base.copyWith(
      textTheme: _textTheme(base.textTheme, largeText, Brightness.light),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: deepSaffron,
        foregroundColor: Colors.white,
        titleTextStyle: GoogleFonts.notoSansDevanagari(
          fontSize: largeText ? 22 : 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: deepSaffron,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: deepSaffron,
        foregroundColor: Colors.white,
      ),
    );
  }

  static ThemeData dark(bool largeText) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: saffron,
        brightness: Brightness.dark,
        primary: saffron,
        secondary: const Color(0xFF4CAF50),
      ),
    );

    return base.copyWith(
      textTheme: _textTheme(base.textTheme, largeText, Brightness.dark),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF1A1A1A),
        foregroundColor: saffron,
        titleTextStyle: GoogleFonts.notoSansDevanagari(
          fontSize: largeText ? 22 : 20,
          fontWeight: FontWeight.w600,
          color: saffron,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: saffron,
        unselectedItemColor: Colors.grey.shade500,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF121212),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        color: const Color(0xFF1E1E1E),
      ),
    );
  }

  static TextTheme _textTheme(TextTheme base, bool largeText, Brightness brightness) {
    final font = GoogleFonts.notoSansDevanagariTextTheme(base);
    final scale = largeText ? 1.15 : 1.0;

    return font.copyWith(
      displayLarge: font.displayLarge?.copyWith(fontSize: (57 * scale)),
      displayMedium: font.displayMedium?.copyWith(fontSize: (45 * scale)),
      displaySmall: font.displaySmall?.copyWith(fontSize: (36 * scale)),
      headlineLarge: font.headlineLarge?.copyWith(fontSize: (32 * scale)),
      headlineMedium: font.headlineMedium?.copyWith(fontSize: (28 * scale)),
      headlineSmall: font.headlineSmall?.copyWith(fontSize: (24 * scale)),
      titleLarge: font.titleLarge?.copyWith(fontSize: (22 * scale), fontWeight: FontWeight.w600),
      titleMedium: font.titleMedium?.copyWith(fontSize: (16 * scale), fontWeight: FontWeight.w600),
      titleSmall: font.titleSmall?.copyWith(fontSize: (14 * scale), fontWeight: FontWeight.w600),
      bodyLarge: font.bodyLarge?.copyWith(fontSize: (16 * scale)),
      bodyMedium: font.bodyMedium?.copyWith(fontSize: (14 * scale)),
      bodySmall: font.bodySmall?.copyWith(fontSize: (12 * scale)),
      labelLarge: font.labelLarge?.copyWith(fontSize: (14 * scale)),
    );
  }
}
