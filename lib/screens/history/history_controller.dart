import 'package:get/get.dart';

enum SubmissionStatus { approved, pending, rejected }

class HistoryItem {
  final String title;
  final String quantity;
  final String date;
  final int points;
  final SubmissionStatus status;
  final String image;
  final String? note;

  HistoryItem({
    required this.title,
    required this.quantity,
    required this.date,
    required this.points,
    required this.status,
    required this.image,
    this.note,
  });
}

class HistoryController extends GetxController {
  final List<HistoryItem> items = [
    HistoryItem(
      title: 'Plastic Bottles',
      quantity: '5 Bottles',
      date: '20-12-2024',
      points: 50,
      status: SubmissionStatus.approved,
      image: 'assets/images/plastic.jpg',
    ),
    HistoryItem(
      title: 'Glass Jars',
      quantity: '3 Jars',
      date: '18-12-2024',
      points: 0,
      status: SubmissionStatus.pending,
      image: 'assets/images/plastic.jpg',
    ),
    HistoryItem(
      title: 'Paper Cardboard',
      quantity: '2 Kg',
      date: '15-12-2024',
      points: 30,
      status: SubmissionStatus.approved,
      image: 'assets/images/plastic.jpg',
    ),
    HistoryItem(
      title: 'Metal Cans',
      quantity: '8 Cans',
      date: '12-12-2024',
      points: 0,
      status: SubmissionStatus.rejected,
      image: 'assets/images/plastic.jpg',
      note:
          'Items not clean enough for recycling.\nPlease rinse containers before submitting.',
    ),
  ];

  int get totalSubmissions => items.length;

  int get totalPoints => items
      .where((e) => e.status == SubmissionStatus.approved)
      .fold(0, (sum, e) => sum + e.points);
}
