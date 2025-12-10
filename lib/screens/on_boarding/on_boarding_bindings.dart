import 'package:eco_cycle/screens/on_boarding/on_boarding_controller.dart';
import 'package:get/get.dart';

class OnBoardingBindings  extends Bindings{
  @override
  void dependencies() {
    Get.put<OnBoardingController>(OnBoardingController());
  }
  
}