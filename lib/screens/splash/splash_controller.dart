import 'package:eco_cycle/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _goNext();
  }

  _goNext() async {
    await Future.delayed(Duration(seconds: 2));
    // firebase logic
    Get.offAllNamed(Routes.ONBOARDING);
  }
}
