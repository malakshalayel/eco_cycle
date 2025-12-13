import 'package:eco_cycle/screens/login/login_controller.dart';
import 'package:eco_cycle/services/auth_services.dart';
import 'package:get/instance_manager.dart';

class LoginBindings extends Bindings{
  @override
  void dependencies() {
     Get.lazyPut<AuthService>(() => AuthService());
    Get.lazyPut<LoginController>(() => LoginController());
  }
}