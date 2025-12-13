import 'package:get/get.dart';

class SubmissionController extends GetxController {
  // ===== Material Types =====
  final List<String> materials = [
    'Plastic (Bottles, Containers)',
    'Paper (Newspapers, Cardboard)',
    'Glass (Bottles, Jars)',
    'Metal (Cans, Aluminum)',
    'Electronic Waste',
  ];

  String? materialType;
  String? quantity;
  String? location;

  bool isMaterialOpen = false;

  // ===== Validation =====
  bool get canSubmit =>
      materialType != null &&
      quantity != null &&
      quantity!.isNotEmpty &&
      location != null &&
      location!.isNotEmpty;

  // ===== Actions =====
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

  void pickImage() {
    // TODO: Image Picker
  }

  void useCurrentLocation() {
    // TODO: GPS Location
  }

  void submit() {
    // TODO: Firestore Submit
  }
}
