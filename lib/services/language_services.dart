import 'dart:ui';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageServices extends GetxService {
  final _box = GetStorage();
  final _key = 'app_language';

  Locale? currentLocale() {
    String? saved = _box.read(_key);
    if (saved == 'ar') {
      return const Locale('ar', 'PS');
    }
    return const Locale('en', 'US');
  }

  void changeLanguage(String langCode) {
    if (langCode == 'ar') {
      _box.write(_key, 'ar');
      Get.updateLocale(const Locale('ar', 'PS'));
    } else {
      _box.write(_key, 'en');
      Get.updateLocale(const Locale("en", "US"));
    }
  }
}
