import 'package:get/get.dart';

class NavigationController extends GetxController {
  int currentIndex = 0;

  void changeTab(int index) {
    if (index == currentIndex) return;
    currentIndex = index;
    update();
  }
}
