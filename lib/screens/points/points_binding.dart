import 'package:get/get.dart';
import 'points_controller.dart';

class PointsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PointsController());
  }
}
