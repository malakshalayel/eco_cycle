import 'package:eco_cycle/screens/login/login_controller.dart';
import 'package:get/instance_manager.dart';

class LoginBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }
}