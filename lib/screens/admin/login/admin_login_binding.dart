import 'package:eco_cycle/screens/admin/login/admin_login_controller.dart';
import 'package:get/get.dart';

class AdminLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AdminLoginController());
  }
}
