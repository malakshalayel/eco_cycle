import 'package:get/get.dart';
import '../../services/auth_services.dart';
import '../../routes/app_routes.dart';

class LoginController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  bool isLoading = false;

  Future<void> signInWithGoogle() async {
    try {
      isLoading = true;
      update();

      final result = await _authService.signInWithGoogle();

      if (result != null) {
        Get.offAllNamed(Routes.HOME);
      }
    } catch (e) {
      Get.snackbar(
        'Login failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading = false;
      update();
    }
  }
}
