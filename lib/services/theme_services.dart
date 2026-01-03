import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

// class ThemeServices extends GetxService {
//   final _box = GetStorage();
//   final _key = 'isDarkMode';
//   //تخزين الثيم في الداكرة
//   bool isDarkMode() => _box.read(_key) ?? false;
//   // قراءة الثيم من الداكرة
//   void _saveTheme(bool isDark) => _box.write(_key, isDark);
//   // هان عشان ندخلها في ال main من هاد الكلاس
//   ThemeMode theme() => isDarkMode() ? ThemeMode.dark : ThemeMode.light;

//   void switchTheme() {
//     bool newTheme = !isDarkMode();
//     _saveTheme(newTheme);
//     updateSystemUI(newTheme);
//     Get.changeTheme(newTheme ? ThemeData.dark() : ThemeData.light());
//   }

//   // تـغيير الثيم في الجهاز المحاط بال ui للتطبيق
//   void updateSystemUI(bool isDark) {
//     SystemChrome.setSystemUIOverlayStyle(
//       SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
//         systemNavigationBarColor: isDark ? Colors.black : Colors.white,
//         systemNavigationBarIconBrightness: isDark
//             ? Brightness.light
//             : Brightness.dark,
//       ),
//     );
//   }
// }
class ThemeServices {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  ThemeMode get theme =>
      _box.read(_key) == true ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(
      isDarkMode() ? ThemeMode.light : ThemeMode.dark,
    );
    _box.write(_key, !isDarkMode());
  }

  bool isDarkMode() => _box.read(_key) == true;
}
