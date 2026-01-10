import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum RedemptionStatus { pending, approved, rejected }

class AdminRedemptionItem {
  final String id;
  final String userName;
  final int points;
  final double cashValue;
  final String date;
  final RedemptionStatus status;
  final String? note;
  final String userId;

  AdminRedemptionItem({
    required this.id,
    required this.userName,
    required this.points,
    required this.cashValue,
    required this.date,
    required this.status,
    required this.userId,
    this.note,
  });
}

class PointsReviewController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<String, String> _userNameCache = {};
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _subscription;

  String searchQuery = '';
  String selectedFilter = 'Pending Review';
  bool isFilterOpen = false;
  bool isLoading = true;

  List<AdminRedemptionItem> _all = [];

  @override
  void onInit() {
    super.onInit();
    _listenToRedemptions();
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }

  List<String> get filterOptions => const [
        'All Requests',
        'Pending Review',
        'Approved',
        'Rejected',
      ];

  void toggleFilter() {
    isFilterOpen = !isFilterOpen;
    update();
  }

  void selectFilter(String value) {
    selectedFilter = value;
    isFilterOpen = false;
    update();
  }

  void onSearchChanged(String value) {
    searchQuery = value;
    update();
  }

  List<AdminRedemptionItem> get visibleRedemptions {
    final q = searchQuery.trim().toLowerCase();

    Iterable<AdminRedemptionItem> result = _all;

    if (selectedFilter == 'Pending Review') {
      result = result.where((e) => e.status == RedemptionStatus.pending);
    } else if (selectedFilter == 'Approved') {
      result = result.where((e) => e.status == RedemptionStatus.approved);
    } else if (selectedFilter == 'Rejected') {
      result = result.where((e) => e.status == RedemptionStatus.rejected);
    }

    if (q.isNotEmpty) {
      result = result.where((e) {
        return e.userName.toLowerCase().contains(q);
      });
    }

    return result.toList();
  }

  String get filterSummaryText {
    switch (selectedFilter) {
      case 'Pending Review':
        return '${visibleRedemptions.length} pending review';
      case 'Approved':
        return '${visibleRedemptions.length} approved';
      case 'Rejected':
        return '${visibleRedemptions.length} rejected';
      default:
        return '${visibleRedemptions.length} requests';
    }
  }

  Future<void> approve(String id) async {
    await _updateStatus(id, 'approved');
  }

  Future<void> reject(String id, {required String reason}) async {
    await _rejectWithRefund(id, reason);
  }

  void _listenToRedemptions() {
    isLoading = true;
    update();

    _subscription = _firestore
        .collection('points_redemptions')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) async {
      await _ensureUserNames(snapshot.docs);
      _all = snapshot.docs.map(_mapRedemption).toList();
      isLoading = false;
      update();
    }, onError: (_) {
      isLoading = false;
      Get.snackbar('Error', 'Failed to load redemptions');
      update();
    });
  }

  Future<void> _ensureUserNames(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) async {
    final userIds = docs
        .map((doc) => doc.data()['userId'])
        .whereType<String>()
        .toSet();
    final missingIds =
        userIds.where((id) => !_userNameCache.containsKey(id)).toList();

    if (missingIds.isEmpty) return;

    await Future.wait(missingIds.map((id) async {
      final userDoc = await _firestore.collection('users').doc(id).get();
      final data = userDoc.data();
      final name = (data?['name'] ?? data?['email'] ?? 'Unknown user').toString();
      _userNameCache[id] = name;
    }));
  }

  AdminRedemptionItem _mapRedemption(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    final userId = data['userId']?.toString() ?? '';
    final points = _readPoints(data['points']);
    final cashValue = _readCashValue(data['cashValue']);
    final status = _mapStatus(data['status']?.toString());

    return AdminRedemptionItem(
      id: doc.id,
      userName: _userNameCache[userId] ?? 'Unknown user',
      points: points,
      cashValue: cashValue,
      date: _formatDate(data['createdAt']),
      status: status,
      userId: userId,
      note: data['note']?.toString(),
    );
  }

  RedemptionStatus _mapStatus(String? value) {
    switch (value) {
      case 'approved':
        return RedemptionStatus.approved;
      case 'rejected':
        return RedemptionStatus.rejected;
      default:
        return RedemptionStatus.pending;
    }
  }

  int _readPoints(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.round();
    return 0;
  }

  double _readCashValue(dynamic value) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return 0;
  }

  String _formatDate(dynamic value) {
    if (value is Timestamp) {
      return DateFormat('yyyy-MM-dd').format(value.toDate());
    }
    if (value is DateTime) {
      return DateFormat('yyyy-MM-dd').format(value);
    }
    return '';
  }

  Future<void> _updateStatus(String id, String status) async {
    try {
      await _firestore.collection('points_redemptions').doc(id).update({
        'status': status,
        'note': null,
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to update redemption');
    }
  }

  Future<void> _rejectWithRefund(String id, String reason) async {
    try {
      final redemptionRef = _firestore.collection('points_redemptions').doc(id);
      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(redemptionRef);
        if (!snapshot.exists) return;
        final data = snapshot.data() as Map<String, dynamic>;
        if (data['status'] == 'rejected') return;

        final points = _readPoints(data['points']);
        final userId = data['userId']?.toString();

        transaction.update(redemptionRef, {
          'status': 'rejected',
          'note': reason.trim(),
        });

        if (userId != null && userId.isNotEmpty && points > 0) {
          final userRef = _firestore.collection('users').doc(userId);
          transaction.update(userRef, {
            'pointsBalance': FieldValue.increment(points),
          });
        }
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to reject redemption');
    }
  }
}
