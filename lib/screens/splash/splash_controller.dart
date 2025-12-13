import 'package:eco_cycle/routes/app_routes.dart';
import 'package:eco_cycle/services/auth_services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final GetStorage _storage = GetStorage() ;
  @override
  void onInit() {
    super.onInit();
    _goNext();
  }

  

  _goNext() async {
    await Future.delayed(Duration(seconds: 2));
    final bool seenOnboarding = _storage.read('seenOnboarding') ?? false;
    if(!seenOnboarding) {
      Get.offAllNamed(Routes.ONBOARDING);
      return;
    }
    if ( _authService.currentUser != null) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }

  }
}
