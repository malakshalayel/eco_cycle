import 'package:eco_cycle/firebase_options.dart';
import 'package:eco_cycle/localization/app_translations.dart';
import 'package:eco_cycle/routes/app_pages.dart';
import 'package:eco_cycle/services/auth_services.dart';
import 'package:eco_cycle/services/language_services.dart';
import 'package:eco_cycle/services/theme_services.dart';
import 'package:eco_cycle/styles/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
      Get.put<AuthService>(AuthService(), permanent: true);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark, // للـ Light Mode
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  Get.put(LanguageServices());
  Get.put(ThemeServices());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final langServices = Get.find<LanguageServices>();
    final themeServices = Get.find<ThemeServices>();
    return ScreenUtilInit(
      designSize: const Size(390, 844), // مطابق للفيجما
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        translations: AppTranslations(),
        locale: langServices.currentLocale(),
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeServices.theme(),
        fallbackLocale: const Locale('en', 'US'),
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        home: child,
      ),
      child: const SizedBox(),
    );
  }
}
