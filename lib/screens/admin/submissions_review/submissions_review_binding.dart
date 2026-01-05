import 'package:get/get.dart';
import 'submissions_review_controller.dart';

class SubmissionsReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SubmissionsReviewController>(SubmissionsReviewController());
  }
}
