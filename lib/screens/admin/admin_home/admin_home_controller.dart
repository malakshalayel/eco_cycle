import 'package:get/get.dart';

class AdminHomeController extends GetxController {
  int get totalSubmissions => 1247;
  int get activeUsers => 342;
  int get pointsAwarded => 45680;
  int get pendingReviews => 23;

  List<Map<String, dynamic>> get topRecyclers => [
        {
          'rank': 1,
          'name': 'Jessica Smith',
          'submissions': 18,
          'points': '2,450',
        },
        {
          'rank': 2,
          'name': 'Mike Johnson',
          'submissions': 15,
          'points': '2,100',
        },
        {
          'rank': 3,
          'name': 'Sarah Williams',
          'submissions': 15,
          'points': '1,850',
        },
        {
          'rank': 4,
          'name': 'David Brown',
          'submissions': 10,
          'points': '1,600',
        },
        {
          'rank': 5,
          'name': 'Lisa Davis',
          'submissions': 8,
          'points': '1,400',
        },
      ];
}
