
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_cycle/screens/history/model/submission_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


// class HistoryItem {
//   final String title;
//   final String quantity;
//   final String date;
//   final int points;
//   final SubmissionStatus status;
//   final String image;
//   final String? note;

//   HistoryItem({
//     required this.title,
//     required this.quantity,
//     required this.date,
//     required this.points,
//     required this.status,
//     required this.image,
//     this.note,
//   });
// }

class HistoryController extends GetxController {
bool isLoading = true; 
final _fireStore = FirebaseFirestore.instance ; 
final _auth = FirebaseAuth.instance ;
List<SubmissionModel> submissions = [];
@override
 onInit(){
    super.onInit(); 
fetchHistory();
print('SUBMISSIONS COUNT: ${submissions.length}');

}
Future<void> fetchHistory() async {
  try {
    isLoading = true;
    update();

    final user = _auth.currentUser;
    if (user == null) return;

    final snapshot = await _fireStore
        .collection('submissions')
        .where('userId', isEqualTo: user.uid)
        .orderBy('createdAt', descending: true)
        .get();

    submissions = snapshot.docs
        .map((doc) => SubmissionModel.fromFirestore(doc))
        .toList();

    update();
  } catch (e) {
    debugPrint('History error: $e');
  } finally {
    isLoading = false;
    update();
  }
}



  int get totalSubmissions => submissions.length;

  int get totalPoints => submissions
      .where((e) => e.status == SubmissionStatus.approved)
      .fold(0, (sum, e) => sum);
}
