import 'package:get/get.dart';

import '../home/home_controller.dart';
import '../submission/submission_controller.dart';
import '../history/history_controller.dart';
import '../points/points_controller.dart';
import '../profile/profile_controller.dart';
import 'navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    // Bottom nav controller
    Get.lazyPut(() => NavigationController(), fenix: true);

    // Tabs controllers (VERY IMPORTANT)
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => SubmissionController(), fenix: true);
    Get.lazyPut(() => HistoryController(), fenix: true);
    Get.lazyPut(() => PointsController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
  }
}
