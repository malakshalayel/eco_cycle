import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum SubmissionStatus { pending, approved, rejected }

class AdminSubmissionItem {
  final String id;
  final String userName;
  final String materialTitle;
  final String location;
  final String date;
  final int points;
  SubmissionStatus status;
  final String? rejectReason;
  final String imageUrl;

  AdminSubmissionItem({
    required this.id,
    required this.userName,
    required this.materialTitle,
    required this.location,
    required this.date,
    required this.points,
    required this.status,
    this.rejectReason,
    required this.imageUrl,
  });
}

class SubmissionsReviewController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<String, String> _userNameCache = {};
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _subscription;
  static const Map<String, int> _materialBasePoints = {
    'plastic': 10,
    'paper': 6,
    'glass': 8,
    'metal': 12,
    'electronic': 20,
  };

  //  UI STATE 
  String searchQuery = '';
  String selectedFilter = 'Pending Review';
  bool isFilterOpen = false;
  bool isLoading = true;

  //  DATA 
  List<AdminSubmissionItem> _all = [];

  @override
  void onInit() {
    super.onInit();
    _listenToSubmissions();
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }

  //  FILTER OPTIONS 
  List<String> get filterOptions => const [
        'All Submissions',
        'Pending Review',
        'Approved',
        'Rejected',
      ];

  //  ACTIONS 
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

  //  FILTERED DATA 
  List<AdminSubmissionItem> get visibleSubmissions {
    final q = searchQuery.trim().toLowerCase();

    Iterable<AdminSubmissionItem> result = _all;

    // فلترة حسب الحالة
    if (selectedFilter == 'Pending Review') {
      result = result.where((e) => e.status == SubmissionStatus.pending);
    } else if (selectedFilter == 'Approved') {
      result = result.where((e) => e.status == SubmissionStatus.approved);
    } else if (selectedFilter == 'Rejected') {
      result = result.where((e) => e.status == SubmissionStatus.rejected);
    }

    // فلترة حسب البحث (اسم المستخدم أو المادة)
    if (q.isNotEmpty) {
      result = result.where((e) {
        return e.userName.toLowerCase().contains(q) ||
            e.materialTitle.toLowerCase().contains(q);
      });
    }

    return result.toList();
  }

  //  HEADER TEXT 
  String get filterSummaryText {
    switch (selectedFilter) {
      case 'Pending Review':
        return '${visibleSubmissions.length} pending review';
      case 'Approved':
        return '${visibleSubmissions.length} approved';
      case 'Rejected':
        return '${visibleSubmissions.length} rejected';
      default:
        return '${visibleSubmissions.length} submissions';
    }
  }

  // CARD ACTIONS 
  Future<void> approve(String id) async {
    await _approveWithPoints(id);
  }

  Future<void> reject(String id, {required String reason}) async {
    await _rejectWithReason(id, reason);
  }

  void _listenToSubmissions() {
    isLoading = true;
    update();

    _subscription = _firestore
        .collection('submissions')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) async {
      await _ensureUserNames(snapshot.docs);
      _all = snapshot.docs.map(_mapSubmission).toList();
      isLoading = false;
      update();
    }, onError: (_) {
      isLoading = false;
      Get.snackbar('Error', 'Failed to load submissions');
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

  AdminSubmissionItem _mapSubmission(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    final userId = data['userId']?.toString() ?? '';
    final material = data['materialType']?.toString() ?? 'Material';
    final quantity = data['quantity']?.toString() ?? '';
    final location = data['location']?.toString() ?? '';
    final imageUrl = data['imageUrl']?.toString() ?? '';
    final status = _mapStatus(data['status']?.toString());

    return AdminSubmissionItem(
      id: doc.id,
      userName: _userNameCache[userId] ?? 'Unknown user',
      materialTitle:
          quantity.isEmpty ? material : '$material · $quantity',
      location: location,
      date: _formatDate(data['createdAt']),
      points: _readPoints(data['pointsAwarded']),
      status: status,
      rejectReason: data['note']?.toString(),
      imageUrl: imageUrl,
    );
  }

  SubmissionStatus _mapStatus(String? value) {
    switch (value) {
      case 'approved':
        return SubmissionStatus.approved;
      case 'rejected':
        return SubmissionStatus.rejected;
      default:
        return SubmissionStatus.pending;
    }
  }

  int _readPoints(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.round();
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
      await _firestore.collection('submissions').doc(id).update({
        'status': status,
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to update submission');
    }
  }
  Future<void> _approveWithPoints(String id) async {
    try {
      final submissionRef = _firestore.collection('submissions').doc(id);
      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(submissionRef);
        if (!snapshot.exists) return;
        final data = snapshot.data() as Map<String, dynamic>;
        if (data['status'] == 'approved') return;

        final materialType = data['materialType']?.toString() ?? '';
        final quantityText = data['quantity']?.toString() ?? '';
        final pointsAwarded = _calculatePoints(materialType, quantityText);
        final userId = data['userId']?.toString();

        transaction.update(submissionRef, {
          'status': 'approved',
          'pointsAwarded': pointsAwarded,
          'note': null,
        });

        if (userId != null && userId.isNotEmpty) {
          final userRef = _firestore.collection('users').doc(userId);
          transaction.update(userRef, {
            'pointsBalance': FieldValue.increment(pointsAwarded),
          });
        }
      });
    } catch (e, s) {
      log('Approve failed: $e');
      log('Approve stack: $s');
      Get.snackbar('Error', 'Failed to approve submission');
    }
  }

  Future<void> _rejectWithReason(String id, String reason) async {
    try {
      await _firestore.collection('submissions').doc(id).update({
        'status': 'rejected',
        'note': reason.trim(),
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to reject submission');
    }
  }

  int _calculatePoints(String materialType, String quantityText) {
    final base = _basePointsForMaterial(materialType);
    final quantity = _extractQuantityNumber(quantityText);
    final points = base * quantity;
    return points.round();
  }

  int _basePointsForMaterial(String materialType) {
    final key = materialType.toLowerCase();
    for (final entry in _materialBasePoints.entries) {
      if (key.contains(entry.key)) return entry.value;
    }
    return 0;
  }

  double _extractQuantityNumber(String text) {
    final match = RegExp(r'(\d+(\.\d+)?)').firstMatch(text);
    if (match == null) return 1;
    final value = double.tryParse(match.group(1) ?? '');
    if (value == null || value <= 0) return 1;
    return value;
  }
}
