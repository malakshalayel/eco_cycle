import 'package:get/get.dart';

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

  AdminSubmissionItem({
    required this.id,
    required this.userName,
    required this.materialTitle,
    required this.location,
    required this.date,
    required this.points,
    required this.status,
    this.rejectReason,
  });
}

class SubmissionsReviewController extends GetxController {
  //  UI STATE 
  String searchQuery = '';
  String selectedFilter = 'Pending Review';
  bool isFilterOpen = false;

  //  DATA 
  final List<AdminSubmissionItem> _all = [
    AdminSubmissionItem(
      id: '1',
      userName: 'Jessica Smith',
      materialTitle: 'Plastic Bottles · 5 Bottles',
      location: 'Downtown Community Center',
      date: '2024-01-20',
      points: -50,
      status: SubmissionStatus.pending,
    ),
    AdminSubmissionItem(
      id: '2',
      userName: 'Mike Johnson',
      materialTitle: 'Glass Jars · 3 jars',
      location: 'West Side Recycling Center',
      date: '2024-01-20',
      points: -30,
      status: SubmissionStatus.pending,
    ),
    AdminSubmissionItem(
      id: '3',
      userName: 'Sarah Williams',
      materialTitle: 'Paper/Cardboard · 2 kg',
      location: 'East End Collection Point',
      date: '2024-01-19',
      points: -25,
      status: SubmissionStatus.approved,
    ),
    AdminSubmissionItem(
      id: '4',
      userName: 'David Brown',
      materialTitle: 'Metal Cans · 8 cans',
      location: 'Central Plaza',
      date: '2024-01-19',
      points: -40,
      status: SubmissionStatus.rejected,
      rejectReason: 'Rejected: Items not clean enough for recycling',
    ),
  ];

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
  void approve(String id) {
    final item = _all.firstWhere((e) => e.id == id);
    item.status = SubmissionStatus.approved;
    update();
  }

  void reject(String id) {
    final item = _all.firstWhere((e) => e.id == id);
    item.status = SubmissionStatus.rejected;
    update();
  }
}
