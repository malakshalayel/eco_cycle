import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum PointsTab { redeem, history }

class PointsHistoryItem {
  final String title;
  final String date;
  final int points;
  final String status;

  PointsHistoryItem({
    required this.title,
    required this.date,
    required this.points,
    required this.status,
  });
}

class PointsController extends GetxController {
  int totalPoints = 2450;

  PointsTab currentTab = PointsTab.redeem;

  void changeTab(PointsTab tab) {
    currentTab = tab;
    update();
  }

  final TextEditingController pointsController = TextEditingController(
    text: '200',
  );
  final TextEditingController ibanController = TextEditingController(
    text: 'PS92 PIBC 0000 01234 5678 9012',
  );
  final TextEditingController swiftController = TextEditingController(
    text: 'PIBCPS22XXX',
  );

  double get cashValue {
    final points = int.tryParse(pointsController.text) ?? 0;
    return points / 100;
  }

  final List<PointsHistoryItem> history = [
    // PointsHistoryItem(
    //   title: 'Eco-Friendly Water Bottle',
    //   date: '2024-01-18',
    //   points: 500,
    //   status: 'Approved',
    // ),
    // PointsHistoryItem(
    //   title: 'Cash Conversion - \$25',
    //   date: '2024-01-15',
    //   points: -2500,
    //   status: 'Pending',
    // ),
    //   PointsHistoryItem(
    //   title: 'Cash Conversion - \$25',
    //   date: '2024-01-15',
    //   points: -2500,
    //   status: 'Pending',
    // ),
    // PointsHistoryItem(
    //   title: 'Recycled Tote Bag',
    //   date: '2024-01-10',
    //   points: 300,
    //   status: 'Approved',
    // ),
    //   PointsHistoryItem(
    //   title: 'Recycled Tote Bag',
    //   date: '2024-01-10',
    //   points: 300,
    //   status: 'Approved',
    // ),
  ];

  @override
  void onClose() {
    pointsController.dispose();
    ibanController.dispose();
    swiftController.dispose();
    super.onClose();
  }
}
