import 'package:eco_cycle/screens/home/home_controller.dart';
import 'package:get/get.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() { 
    Get.lazyPut(() => HomeController()); 
  }}