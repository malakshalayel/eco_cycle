import 'package:eco_cycle/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

// class AppTheme {
//   static ThemeData lightTheme = ThemeData(
//     useMaterial3: true,
//     scaffoldBackgroundColor: Colors.white,
//     fontFamily: Get.locale?.countryCode == 'en' ? 'Roboto' : 'Cairo',
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       centerTitle: true,
//       foregroundColor: Colors.black,
//     ),
//   );

//   static ThemeData darkTheme = ThemeData(
//     useMaterial3: true,
//     scaffoldBackgroundColor: Colors.black,
//     fontFamily: Get.locale?.countryCode == 'en' ? 'Roboto' : 'Cairo',
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Colors.black,
//       elevation: 0,
//       centerTitle: true,
//       foregroundColor: Colors.white,
//     ),
//   );
// }

// class AppTheme {
//  static ThemeData lightTheme = ThemeData(
//   useMaterial3: true,
//   scaffoldBackgroundColor: const Color(0xFFF6F6F6),

//   colorScheme: ColorScheme.light(
//     primary: const Color(0xFF6A5FA8), // نفس لون الهوم
//     onPrimary: Colors.white,
//   ),

//   appBarTheme: const AppBarTheme(
//     backgroundColor: Color(0xFF6A5FA8),
//     foregroundColor: Colors.white,
//     elevation: 0,
//     centerTitle: true,
//   ),

//   textTheme: const TextTheme(
//     titleLarge: TextStyle(
//       fontSize: 18,
//       fontWeight: FontWeight.w600,
//       color: Colors.white,
//     ),
//   ),
// );

//  static ThemeData darkTheme = ThemeData(
//   brightness: Brightness.dark,
//   scaffoldBackgroundColor: AppColors.darkBg,
//   primaryColor: AppColors.primary,

//   cardColor: AppColors.darkCard,

//   textTheme: const TextTheme(
//     bodyLarge: TextStyle(
//       color: Color(0xFFEDEDED), // primary text
//     ),
//     bodyMedium: TextStyle(
//       color: Color(0xFFCCCCCC),
//     ),
//     bodySmall: TextStyle(
//       color: Color(0xFFB3B3B3),
//     ),
//   ),

//    appBarTheme: const AppBarTheme(
//     backgroundColor: Color(0xFF6A5FA8),
//     foregroundColor: Colors.white,
//     elevation: 0,
//     centerTitle: true,
//   ),
// );

// }
class AppTheme {
  /// 🌞 Light Theme (نفس روح الدارك لكن أفتح)
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    scaffoldBackgroundColor: const Color(0xFFF4F3F9),

    colorScheme: const ColorScheme.light(
      primary: Color(0xFF6A5FA8),
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: Color(0xFF1A1A1A),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF6A5FA8),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),

    cardColor: Colors.white,

    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white, // AppBar title
      ),
      bodyLarge: TextStyle(
        color: Color(0xFF1A1A1A),
      ),
      bodyMedium: TextStyle(
        color: Color(0xFF4A4A4A),
      ),
      bodySmall: TextStyle(
        color: Color(0xFF7A7A7A),
      ),
    ),

    dividerColor: Color(0xFFE0E0E0),
  );

  /// 🌙 Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    scaffoldBackgroundColor: const Color(0xFF0F0F14),

    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF6A5FA8),
      onPrimary: Colors.white,
      surface: Color(0xFF1C1C23),
      onSurface: Color(0xFFEDEDED),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF6A5FA8),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),

    cardColor: const Color(0xFF1C1C23),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Color(0xFFEDEDED),
      ),
      bodyMedium: TextStyle(
        color: Color(0xFFCCCCCC),
      ),
      bodySmall: TextStyle(
        color: Color(0xFFB3B3B3),
      ),
    ),

    dividerColor: Color(0xFF2A2A33),
  );
}
