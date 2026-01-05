import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices extends GetxController {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  ThemeMode get theme =>
      _box.read(_key) == true ? ThemeMode.dark : ThemeMode.light;

  bool get isDark => theme == ThemeMode.dark;

  void switchTheme() {
    final isDarkMode = !isDark;
    _box.write(_key, isDarkMode);

    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);

    _applySystemUI(isDarkMode);
  }

  @override
  void onInit() {
    super.onInit();
    _applySystemUI(isDark);
  }

  void _applySystemUI(bool dark) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            dark ? Brightness.light : Brightness.dark,

        systemNavigationBarColor:
            dark ? const Color(0xFF121212) : const Color(0xFFF6F6F6),

        systemNavigationBarIconBrightness:
            dark ? Brightness.light : Brightness.dark,
      ),
    );
  }
}
