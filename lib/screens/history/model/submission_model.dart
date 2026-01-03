import 'package:cloud_firestore/cloud_firestore.dart';

enum SubmissionStatus { pending, approved, rejected }

class SubmissionModel {
  final String id;
  final String materialType;
  final String quantity;
  final String location;
  final String imageUrl;
  final SubmissionStatus status;
  final int pointsAwarded;
  final DateTime createdAt;
  final String userId;
  final String? note;

  SubmissionModel({
    required this.id,
    required this.materialType,
    required this.quantity,
    required this.location,
    required this.imageUrl,
    required this.status,
    required this.pointsAwarded,
    required this.createdAt,
    required this.userId,
    this.note,
  });

  /// 🔄 Firestore → Model
  factory SubmissionModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return SubmissionModel(
      id: doc.id,
      materialType: data['materialType'],
      quantity: data['quantity'],
      location: data['location'],
      imageUrl: data['imageUrl'],
      status: _mapStatus(data['status']),
      pointsAwarded: data['pointsAwarded'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      userId: data['userId'],
      note: data['note'],
    );
  }

  static SubmissionStatus _mapStatus(String value) {
    switch (value) {
      case 'approved':
        return SubmissionStatus.approved;
      case 'rejected':
        return SubmissionStatus.rejected;
      default:
        return SubmissionStatus.pending;
    }
  }
}
