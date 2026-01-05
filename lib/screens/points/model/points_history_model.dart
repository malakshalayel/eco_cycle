import 'package:cloud_firestore/cloud_firestore.dart';

class PointsHistoryModel {
  final int points;
  final double cashValue;
  final String status;
  final DateTime date;

  PointsHistoryModel({
    required this.points,
    required this.cashValue,
    required this.status,
    required this.date,
  });

  factory PointsHistoryModel.fromMap(Map<String, dynamic> data) {
    return PointsHistoryModel(
      points: data['points'],
      cashValue: (data['cashValue'] as num).toDouble(),
      status: data['status'],
      date: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
