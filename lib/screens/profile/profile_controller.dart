import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class ProfileController extends GetxController {
  final User? user = FirebaseAuth.instance.currentUser;

  String get name => user?.displayName ?? '';
  String get email => user?.email ?? '';
  String get avatarUrl => user?.photoURL ?? '';

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> deleteAccount() async {
    await user?.delete();
    Get.offAllNamed(Routes.LOGIN);
  }
}
