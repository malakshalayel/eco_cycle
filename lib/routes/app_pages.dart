import 'package:eco_cycle/routes/app_routes.dart';
import 'package:eco_cycle/screens/history/history_binding.dart';
import 'package:eco_cycle/screens/history/history_view.dart';
import 'package:eco_cycle/screens/home/home_bindings.dart';
import 'package:eco_cycle/screens/home/home_view.dart';
import 'package:eco_cycle/screens/login/login_bindings.dart';
import 'package:eco_cycle/screens/login/login_view.dart';
import 'package:eco_cycle/screens/navigation/navigation_binding.dart';
import 'package:eco_cycle/screens/navigation/navigation_view.dart';
import 'package:eco_cycle/screens/on_boarding/on_boarding_bindings.dart';
import 'package:eco_cycle/screens/on_boarding/on_boarding_view.dart';
import 'package:eco_cycle/screens/points/points_binding.dart';
import 'package:eco_cycle/screens/points/points_view.dart';
import 'package:eco_cycle/screens/profile/profile_binding.dart';
import 'package:eco_cycle/screens/profile/profile_view.dart';
import 'package:eco_cycle/screens/splash/splash_binding.dart';
import 'package:eco_cycle/screens/splash/splash_view.dart';
import 'package:eco_cycle/screens/submission/submission_binding.dart';
import 'package:eco_cycle/screens/submission/submission_view.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.HOME;

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
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBindings(),
    ),
    // GetPage(
    //   name: Routes.HOME,
    //   page: () => const NavigationView(),
    //   binding: NavigationBinding(),
    // ),
    GetPage(
      name: Routes.SUBMISSION_HISTORY,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: Routes.POINTS,
      page: () => const PointsView(),
      binding: PointsBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
