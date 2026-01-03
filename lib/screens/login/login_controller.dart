import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../services/auth_services.dart';
import '../../routes/app_routes.dart';

class LoginController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance ;

  bool isLoading = false;

  Future<void> signInWithGoogle() async {
    try {
      isLoading = true;
      update();

      final result = await _authService.signInWithGoogle();

     final user = result?.user ;
     if(user == null ) return ;
final userRef = _fireStore.collection('users').doc(user.uid) ;
final snapshot =await userRef.get(); 
final now  = FieldValue.serverTimestamp(); 
//first login
 if(!snapshot.exists) { 
  await userRef.set({ 
    'uid': user.uid,
          'name': user.displayName ?? '',
          'email': user.email ?? '',
          'photoUrl': user.photoURL ?? '',
          'pointsBalance': 0,
          'createdAt': now,
          'lastLoginAt': now,

  }) ;

 }else{ 
  //update login time 
  await userRef.update( 
    { 
      'lastLoginAt': now,
    }
  );
 }
  Get.offAllNamed(Routes.NAVIGATION);
    } catch (e) {
      Get.snackbar(
        'Login failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading = false;
      update();
    }
  }
}
