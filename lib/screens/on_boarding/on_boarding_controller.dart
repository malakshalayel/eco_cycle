import 'package:eco_cycle/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingController extends GetxController {
  final PageController pageController = PageController();
  final GetStorage _storage = GetStorage();

  int currentIndex = 0;
  void onPageChanged(int index) {
    currentIndex = index;
    update();
  }

  void nextPage() {
    if (currentIndex < 2) {
      pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _storage.write('seenOnboarding', true);

      Get.offAllNamed(Routes.LOGIN);
    }
  }

  void skip() {
_storage.write('seenOnboarding', true);
    Get.offAllNamed(Routes.LOGIN);
  }
}
