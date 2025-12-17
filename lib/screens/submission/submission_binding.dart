import 'package:get/get.dart';
import 'submission_controller.dart';

class SubmissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SubmissionController>(SubmissionController());
  }
}
