import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeController extends GetxController {
  final user = FirebaseAuth.instance.currentUser;

  String get userName => user?.displayName ?? 'User';
  String get photoUrl => user?.photoURL ?? '';
}
