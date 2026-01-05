import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = true;

  // User data
  String userName = '';
  String photoUrl = '';
  int pointsBalance = 0;

  // Temporary (later from submissions)
  int weeklyPoints = 0;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      isLoading = true;
      update();

      final user = _auth.currentUser;
      if (user == null) return;

      final doc =
          await _fireStore.collection('users').doc(user.uid).get();

      if (!doc.exists) return;

      final data = doc.data()!;

      userName = data['name'] ?? '';
      photoUrl = data['photoUrl'] ?? '';
      pointsBalance = (data['pointsBalance'] ?? 0) as int;

      // مؤقتًا (بنربطه لاحقًا من submissions)
      weeklyPoints = 0;

    } catch (e) {
      Get.snackbar('Error', 'Failed to load home data');
    } finally {
      isLoading = false;
      update();
    }
  }
}
