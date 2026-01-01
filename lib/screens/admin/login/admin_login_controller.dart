import 'package:get/get.dart';

class AdminLoginController extends GetxController {
  String email = '';
  String password = '';

  bool isLoading = false;
  String? errorMessage;

  bool get isFormValid =>
      email.trim().isNotEmpty && password.trim().isNotEmpty;

  void onEmailChanged(String value) {
    email = value;
    update();
  }

  void onPasswordChanged(String value) {
    password = value;
    update();
  }

  void login() async {
    if (!isFormValid) return;

    isLoading = true;
    errorMessage = null;
    update();

    await Future.delayed(const Duration(seconds: 2));

    // fake validation
    if (email != 'admin@ecocycle.com' || password != '123456') {
      isLoading = false;
      errorMessage = 'Invalid admin credentials';
      update();
      return;
    }

    isLoading = false;
    update();

    // TODO: navigate to admin dashboard
  }

  void backToUserApp() {
    // TODO: navigate back
  }
}

