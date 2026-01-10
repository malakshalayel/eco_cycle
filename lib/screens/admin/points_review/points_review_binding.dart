import 'package:get/get.dart';
import 'points_review_controller.dart';

class PointsReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PointsReviewController>(PointsReviewController());
  }
}
