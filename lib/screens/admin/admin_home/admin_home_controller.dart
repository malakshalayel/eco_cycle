import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AdminHomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _usersSub;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _submissionsSub;

  int totalSubmissions = 0;
  int activeUsers = 0;
  int pointsAwarded = 0;
  int pendingReviews = 0;
  bool isLoading = true;

  List<Map<String, dynamic>> topRecyclers = [];
  Map<String, int> _submissionCountByUser = {};

  @override
  void onInit() {
    super.onInit();
    _listenToDashboard();
  }

  @override
  void onClose() {
    _usersSub?.cancel();
    _submissionsSub?.cancel();
    super.onClose();
  }

  void _listenToDashboard() {
    isLoading = true;
    update();

    _usersSub = _firestore.collection('users').snapshots().listen((snapshot) {
      activeUsers = snapshot.size;
      pointsAwarded = _sumPoints(snapshot.docs);
      _rebuildTopRecyclers(snapshot.docs);
      isLoading = false;
      update();
    }, onError: (_) {
      Get.snackbar('Error', 'Failed to load users');
    });

    _submissionsSub =
        _firestore.collection('submissions').snapshots().listen((snapshot) {
      totalSubmissions = snapshot.size;
      pendingReviews =
          snapshot.docs.where((d) => d.data()['status'] == 'pending').length;
      _submissionCountByUser = _countSubmissionsByUser(snapshot.docs);
      _rebuildTopRecyclers();
      isLoading = false;
      update();
    }, onError: (_) {
      Get.snackbar('Error', 'Failed to load submissions');
    });
  }

  int _sumPoints(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    int total = 0;
    for (final doc in docs) {
      final value = doc.data()['pointsBalance'];
      if (value is int) {
        total += value.round();
      }
    }  return total;
  }

  void _rebuildTopRecyclers([
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? users,
  ]) {
    final docs = users ?? [];
    if (docs.isEmpty) return;

    final sorted = [...docs]
      ..sort((a, b) {
        final aPoints = (a.data()['pointsBalance'] ?? 0) as num;
        final bPoints = (b.data()['pointsBalance'] ?? 0) as num;
        return bPoints.compareTo(aPoints);
      });

    topRecyclers = sorted.take(5).toList().asMap().entries.map((entry) {
      final idx = entry.key;
      final doc = entry.value;
      final data = doc.data();
      final name =
          (data['name'] ?? data['email'] ?? 'Unknown user').toString();
      final points = data['pointsBalance'] ?? 0;
      final submissions = _submissionCountByUser[doc.id] ?? 0;

      return {
        'rank': idx + 1,
        'name': name,
        'submissions': submissions,
        'points': points.toString(),
      };
    }).toList();
  }

  Map<String, int> _countSubmissionsByUser(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    final Map<String, int> counts = {};
    for (final doc in docs) {
      final userId = doc.data()['userId']?.toString();
      if (userId == null || userId.isEmpty) continue;
      counts[userId] = (counts[userId] ?? 0) + 1;
    }
    return counts;
  }
}