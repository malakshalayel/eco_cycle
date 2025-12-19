import 'package:eco_cycle/routes/app_routes.dart';
import 'package:eco_cycle/screens/home/home_bindings.dart';
import 'package:eco_cycle/screens/home/home_view.dart';
import 'package:eco_cycle/screens/login/login_bindings.dart';
import 'package:eco_cycle/screens/login/login_view.dart';
import 'package:eco_cycle/screens/on_boarding/on_boarding_bindings.dart';
import 'package:eco_cycle/screens/on_boarding/on_boarding_view.dart';
import 'package:eco_cycle/screens/splash/splash_binding.dart';
import 'package:eco_cycle/screens/splash/splash_view.dart';
import 'package:eco_cycle/screens/submission/submission_binding.dart';
import 'package:eco_cycle/screens/submission/submission_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH;

  static final routes = <GetPage>[
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => OnboardingView(),
      binding: OnBoardingBindings(),
    ),
    GetPage(
      name: Routes.SUBMISSION,
      page: () => SubmissionView(),
      binding: SubmissionBinding(),
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnBoardingBindings(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBindings(),
    ),
  ];
}
