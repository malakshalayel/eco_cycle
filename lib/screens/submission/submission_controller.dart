import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SubmissionController extends GetxController {
  //  Material Types 
  final List<String> materials = [
    'Plastic (Bottles, Containers)',
    'Paper (Newspapers, Cardboard)',
    'Glass (Bottles, Jars)',
    'Metal (Cans, Aluminum)',
    'Electronic Waste',
  ];
final TextEditingController locationController = TextEditingController();

  //  Form Values 
  String? materialType;
  String? quantity;
  String? location;

  //  UI State 
  bool isMaterialOpen = false;
  bool isLoading = false; 
  File? selectedImage;

  final ImagePicker _picker = ImagePicker();
final _fireStore = FirebaseFirestore.instance ; 
final _auth = FirebaseAuth.instance ;

  //  Validation 
  bool get canSubmit =>
      materialType != null &&
      quantity != null &&
      quantity!.isNotEmpty &&
      location != null &&
      location!.isNotEmpty &&
      selectedImage != null &&
      !isLoading; 

  //  Actions 
  void toggleMaterial() {
    isMaterialOpen = !isMaterialOpen;
    update();
  }

  void selectMaterial(String value) {
    materialType = value;
    isMaterialOpen = false;
    update();
  }

  void setQuantity(String value) {
    quantity = value;
    update();
  }

  void setLocation(String value) {
    location = value;
    update();
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (image != null) {
      selectedImage = File(image.path);
      update();
    }
  }
   //  Upload to Cloudinary
  Future<String> uploadImageToCloudinary(File image) async {
    const cloudName = 'dqkqcfyw0';
    const uploadPreset = 'eco_cycle_unsigned';

    final uri =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', image.path));

    final response = await request.send();
    final bytes = await response.stream.toBytes();
    final result = json.decode(utf8.decode(bytes));

    if (response.statusCode != 200) {
      throw Exception('Cloudinary upload failed');
    }

    return result['secure_url'];
  }

  void removeImage() {
    selectedImage = null;
    update();
  }

  //  Submit with loading
 Future<void> submit() async {
  if (!canSubmit) return;

  try {
    isLoading = true;
    update();

    final user = _auth.currentUser;
    if (user == null) throw Exception('Not logged in');

    final imageUrl = await uploadImageToCloudinary(selectedImage!);

    await _fireStore.collection('submissions').add({
      'userId': user.uid,
      'materialType': materialType,
      'quantity': quantity,
      'location': location,
      'imageUrl': imageUrl,
      'status': 'pending',
      'pointsAwarded': 0,
      'createdAt': FieldValue.serverTimestamp(),
    });

    materialType = null;
    quantity = null;
    location = null;
    selectedImage = null;
    setQuantity('');
    

    Get.snackbar(
      'Success',
      'Your submission has been sent for review',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF4CAF50),
      colorText: Colors.white,
    );
    Get.back();
  } catch (e) {
    Get.snackbar(
      'Error',
      'Something went wrong, please try again',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFE53935),
      colorText: Colors.white,
    );
  } finally {
    isLoading = false;
    update();
  }
}


 

  Future<void> useCurrentLocation() async {
  try {                                       
    // 1️⃣ Check permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Permission denied',
          'Location permission permanently denied');
      return;
    }

    // 2️⃣ Get position
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // 3️⃣ Convert to address
    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    final place = placemarks.first;

final value = '${place.locality}, ${place.country}';
location = value;
locationController.text = value;
update();    update();
  } catch (e) {
    Get.snackbar('Error', 'Unable to get location');
  }
}

}
