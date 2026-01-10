import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ActivityItem {
  final String title;
  final String pointsLabel;
  final int pointsSign;
  final DateTime createdAt;

  ActivityItem({
    required this.title,
    required this.pointsLabel,
    required this.pointsSign,
    required this.createdAt,
  });
}

class HomeController extends GetxController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _userSub;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _submissionsSub;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _redemptionsSub;

  bool isLoading = true;

  // User data
  String userName = '';
  String photoUrl = '';
  int pointsBalance = 0;

  // Temporary (later from submissions)
  int weeklyPoints = 0;

  List<ActivityItem> recentActivities = [];
  List<ActivityItem> _submissionActivities = [];
  List<ActivityItem> _redemptionActivities = [];

  @override
  void onInit() {
    super.onInit();
    _listenToHomeData();
  }

  @override
  void onClose() {
    _userSub?.cancel();
    _submissionsSub?.cancel();
    _redemptionsSub?.cancel();
    super.onClose();
  }

  void _listenToHomeData() {
    final user = _auth.currentUser;
    if (user == null) return;

    isLoading = true;
    update();

    _userSub = _fireStore.collection('users').doc(user.uid).snapshots().listen(
      (doc) {
        final data = doc.data();
        if (data != null) {
          userName = data['name'] ?? '';
          photoUrl = data['photoUrl'] ?? '';
          pointsBalance = (data['pointsBalance'] ?? 0) as int;
        }
        isLoading = false;
        update();
      },
      onError: (_) {
        isLoading = false;
        Get.snackbar('Error', 'Failed to load home data');
        update();
      },
    );

    _submissionsSub = _fireStore
        .collection('submissions')
        .where('userId', isEqualTo: user.uid)
        .snapshots()
        .listen((snapshot) {
      _submissionActivities = snapshot.docs.map(_mapSubmissionActivity).toList();
      weeklyPoints = _calculateWeeklyPoints(snapshot.docs);
      _mergeActivities();
      update();
    }, onError: (_) {
      Get.snackbar('Error', 'Failed to load submissions');
    });

    _redemptionsSub = _fireStore
        .collection('points_redemptions')
        .where('userId', isEqualTo: user.uid)
        .snapshots()
        .listen((snapshot) {
      _redemptionActivities =
          snapshot.docs.map(_mapRedemptionActivity).toList();
      _mergeActivities();
      update();
    }, onError: (_) {
      Get.snackbar('Error', 'Failed to load redemptions');
    });
  }

  ActivityItem _mapSubmissionActivity(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    final materialType = data['materialType']?.toString() ?? 'Material';
    final status = data['status']?.toString() ?? 'pending';
    final points = _readPoints(data['pointsAwarded']);
    final createdAt = _readDate(data['createdAt']);

    String pointsLabel = 'Pending';
    int pointsSign = 0;
    if (status == 'approved' && points > 0) {
      pointsLabel = '+$points pts';
      pointsSign = 1;
    } else if (status == 'approved') {
      pointsLabel = 'Approved';
    } else if (status == 'rejected') {
      pointsLabel = 'Rejected';
    }

    return ActivityItem(
      title: '$materialType submission',
      pointsLabel: pointsLabel,
      pointsSign: pointsSign,
      createdAt: createdAt,
    );
  }

  ActivityItem _mapRedemptionActivity(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    final status = data['status']?.toString() ?? 'pending';
    final points = _readPoints(data['points']);
    final createdAt = _readDate(data['createdAt']);

    String pointsLabel = 'Pending';
    int pointsSign = 0;
    if (status == 'approved') {
      pointsLabel = '-$points pts';
      pointsSign = -1;
    } else if (status == 'rejected') {
      pointsLabel = 'Rejected';
    }

    return ActivityItem(
      title: 'Points redemption',
      pointsLabel: pointsLabel,
      pointsSign: pointsSign,
      createdAt: createdAt,
    );
  }

  void _mergeActivities() {
    final combined = [..._submissionActivities, ..._redemptionActivities];
    combined.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    recentActivities = combined.take(5).toList();
  }

  int _calculateWeeklyPoints(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    final since = DateTime.now().subtract(const Duration(days: 7));
    int total = 0;
    for (final doc in docs) {
      final data = doc.data();
      if (data['status']?.toString() != 'approved') continue;
      final createdAt = _readDate(data['createdAt']);
      if (createdAt.isBefore(since)) continue;
      total += _readPoints(data['pointsAwarded']);
    }
    return total;
  }

  int _readPoints(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.round();
    return 0;
  }

  DateTime _readDate(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return DateTime.now();
  }
}
