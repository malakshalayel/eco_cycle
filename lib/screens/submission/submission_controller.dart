import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  //  Form Values 
  String? materialType;
  String? quantity;
  String? location;

  //  UI State 
  bool isMaterialOpen = false;
  bool isLoading = false; 
  File? selectedImage;

  final ImagePicker _picker = ImagePicker();

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

  void removeImage() {
    selectedImage = null;
    update();
  }

  //  Submit with loading
 Future<void> submit() async {
  try {
    isLoading = true;
    update();

    
    await Future.delayed(const Duration(seconds: 2));

    Get.snackbar(
      'Success',
      'Your submission has been sent for review',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF4CAF50),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );

    //  تفريغ الفورم
    materialType = null;
    quantity = null;
    location = null;
    selectedImage = null;

  } catch (e) {
    Get.snackbar(
      'Error',
      'Something went wrong, please try again',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFE53935),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: const Icon(Icons.error, color: Colors.white),
    );
  } finally {
    isLoading = false;
    update();
  }
}


  void useCurrentLocation() {
    // TODO
  }
}
