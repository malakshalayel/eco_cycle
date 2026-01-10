import 'package:flutter/material.dart';

class AppTheme {
  /// 🌤 Light Theme (Eco – Modern & Professional)
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    scaffoldBackgroundColor: const Color(0xFFF3F6F2),

    colorScheme: const ColorScheme.light(
      primary: Color(0xFF1F6E5C),
      onPrimary: Colors.white,
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF1E2A24),
      secondary: Color(0xFF8FBF9F),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1F6E5C),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),

    cardColor: Colors.white,

    dividerColor: Color(0xFFE0E6DE),

    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white, // AppBar
      ),
      bodyLarge: TextStyle(
        color: Color(0xFF1E2A24),
      ),
      bodyMedium: TextStyle(
        color: Color(0xFF3F4E48),
      ),
      bodySmall: TextStyle(
        color: Color(0xFF6E7C75),
      ),
    ),
  );

  /// 🌙 Dark Theme (Eco – Deep Forest)
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    scaffoldBackgroundColor: const Color(0xFF0E1512), // أخضر غامق جدًا

    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF6FA58E), // Sage مضيء
      onPrimary: Colors.white,
      surface: Color(0xFF1A2420),
      onSurface: Color(0xFFE6EFEA),
      secondary: Color(0xFF8FB9A8),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1A2420), // غامق مع texture
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),

    cardColor: const Color(0xFF1A2420),

    dividerColor: Color(0xFF2A3A33),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Color(0xFFE6EFEA),
      ),
      bodyMedium: TextStyle(
        color: Color(0xFFB8C5BF),
      ),
      bodySmall: TextStyle(
        color: Color(0xFF8F9F98),
      ),
    ),
  );
}
