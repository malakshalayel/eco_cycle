
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_cycle/routes/app_routes.dart';
import 'package:eco_cycle/screens/admin/admin_home/admin_home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AdminLoginController extends GetxController {
  String email = '';
  String password = '';

  bool isLoading = false;
  String? errorMessage;
 final _auth = FirebaseAuth.instance; 
 final _firestore = FirebaseFirestore.instance;
  bool get isFormValid =>
      email.trim().isNotEmpty && password.trim().isNotEmpty;

  void onEmailChanged(String value) {
    email = value;
    update();
  }

  void onPasswordChanged(String value) {
    password = value;
    update();
  }

  // void login() async {
  //   if (!isFormValid) return;

  //   isLoading = true;
  //   errorMessage = null;
  //   update();

  //   await Future.delayed(const Duration(seconds: 2));

  //   // fake validation
  //   if (email != 'admin@ecocycle.com' || password != '123456') {
  //     isLoading = false;
  //     errorMessage = 'Invalid admin credentials';
  //     update();
  //     return;
  //   }

  //   isLoading = false;
  //   Get.toNamed(Routes.ADMIN_HOME);
  //   update();

  //   // TODO: navigate to admin dashboard
  // }
// Future<void> login() async {
//   if (!isFormValid) return;

//   isLoading = true;
//   errorMessage = null;
//   update();

//   try {
//     final credential = await _auth.signInWithEmailAndPassword(
//       email: email.trim(),
//       password: password.trim(),
//     );

//     final user = credential.user;
//     if (user == null) throw 'Login failed';
// log(user.uid);
//     final doc = await _firestore
//         .collection('users')
//         .doc(user.uid)
//         .get();
// log(_firestore.app.options.projectId);

//         log(doc.id);
//         log(doc.data()?['role']);



//     if (!doc.exists || doc.data()?["role"] != 'admin') {  
//       await _auth.signOut();
//       throw 'Unauthorized admin access';
//     }

//     Get.offAllNamed(Routes.ADMIN_HOME);
//   } catch (e) {
//     log(e.toString());
//     errorMessage = 'Invalid admin credentials';
//   } finally {
//     isLoading = false;
//     update();
//   }
// }
Future<void> login() async {
  try {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
    
    final user = credential.user;
    if (user == null) throw 'Login failed';
    
    log('User UID: ${user.uid}'); // اطبع الـ UID كامل
    
    final doc = await _firestore
      .collection('users')
      .doc(user.uid)
      .get();
    
    log('Document exists: ${doc.exists}'); // شوف اذا الدوكيومنت موجود
    log('Document data: ${doc.data()}'); // اطبع كل الداتا
    
    if (doc.exists) {
      final role = doc.get('role'); // استخدم get بدال []
      log('Role value: $role');
      log('Role type: ${role.runtimeType}');
      
      if (role == 'admin') {
        log('✅ Admin access granted');
        // روح للـ admin dashboard
        Get.toNamed(Routes.ADMIN_HOME);
      } else {
        throw 'Not admin: role is $role';
      }
    } else {
      throw 'Document not found for UID: ${user.uid}';
    }
    
  } catch (e) {
    log('❌ Error: $e');
  }
}

  void backToUserApp() {
    
    // TODO: navigate back
  }
}

