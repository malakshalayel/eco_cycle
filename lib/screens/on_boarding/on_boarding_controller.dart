import 'package:eco_cycle/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class OnBoardingController extends GetxController {
  final PageController pageController = PageController();

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
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  void skip() {
    Get.offAllNamed(Routes.LOGIN);
  }
}
