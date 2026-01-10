
import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_cycle/screens/points/model/points_history_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum PointsTab { redeem, history }

class PointsController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _userSub;

  bool isLoading = true;

  int pointsBalance = 0; // 🔗 from Firestore

  PointsTab currentTab = PointsTab.redeem;

  // Redeem form controllers
  final TextEditingController pointsController = TextEditingController();
  final TextEditingController ibanController = TextEditingController();
  final TextEditingController swiftController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _listenToPointsBalance();
    historyStream();
  }
List<PointsHistoryModel> history = [];

Stream<List<PointsHistoryModel>> historyStream() {
  final user = _auth.currentUser;
  if (user == null) return const Stream.empty();

  return _firestore
      .collection('points_redemptions')
      .where('userId', isEqualTo: user.uid)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map((doc) => PointsHistoryModel.fromMap(doc.data()))
            .toList(),
      );
}


  // 🔥 Live points balance from users/{uid}
  void _listenToPointsBalance() {
    final user = _auth.currentUser;
    if (user == null) return;

    isLoading = true;
    update();

    _userSub = _firestore
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .listen((doc) {
      pointsBalance = (doc.data()?['pointsBalance'] ?? 0) as int;
      isLoading = false;
      update();
    }, onError: (_) {
      isLoading = false;
      Get.snackbar('Error', 'Failed to load points');
      update();
    });
  }

  Future<void> redeemPoints() async {
  final user = _auth.currentUser;
  if (user == null) return;

  final points = int.tryParse(pointsController.text) ?? 0;

  if (points <= 0) {
    Get.snackbar('Error', 'Enter valid points');
    return;
  }

  if (points > pointsBalance) {
    Get.snackbar('Error', 'Not enough points');
    return;
  }

  if (ibanController.text.isEmpty || swiftController.text.isEmpty) {
    Get.snackbar('Error', 'IBAN & SWIFT are required');
    return;
  }

  try {
    final userRef = _firestore.collection('users').doc(user.uid);
    final redemptionRef = _firestore.collection('points_redemptions').doc();

    await _firestore.runTransaction((transaction) async {
      final userSnap = await transaction.get(userRef);
      final currentBalance =
          (userSnap.data()?['pointsBalance'] ?? 0) as int;

      if (points > currentBalance) {
        throw Exception('INSUFFICIENT_POINTS');
      }

      transaction.update(userRef, {
        'pointsBalance': FieldValue.increment(-points),
      });
      transaction.set(redemptionRef, {
        'userId': user.uid,
        'points': points,
        'cashValue': points / 100,
        'iban': ibanController.text.trim(),
        'swift': swiftController.text.trim(),
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      });
    });

    Get.snackbar(
      'Success',
      'Your conversion request was sent',
      snackPosition: SnackPosition.BOTTOM,
    );

    // reset form
    pointsController.clear();
    ibanController.clear();
    swiftController.clear();

  } catch (e , s) {
    if (e.toString().contains('INSUFFICIENT_POINTS')) {
      Get.snackbar('Error', 'Not enough points');
    } else {
      log('$e /$s');
      Get.snackbar('Error', 'Something went wrong');
    }
  }
}


  // 💸 Cash value (example: 100 points = $1)
  double get cashValue {
    final pts = int.tryParse(pointsController.text) ?? 0;
    return pts / 100;
  }

  double get balanceCashValue => pointsBalance / 100;

  void changeTab(PointsTab tab) {
    currentTab = tab;
    update();
  }

  @override
  void onClose() {
    _userSub?.cancel();
    pointsController.dispose();
    ibanController.dispose();
    swiftController.dispose();
    super.onClose();
  }
}
