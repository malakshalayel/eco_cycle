import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../submission_controller.dart';

class UploadItemWidget extends GetView<SubmissionController> {
  const UploadItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return GetBuilder<SubmissionController>(
      builder: (controller) {
        return Center(
          child: GestureDetector(
            onTap: () => _showPicker(context),
            child: Stack(
              children: [
                Container(
                  width: 333.w,
                  height: 194.h,
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      width: 1.5,
                      color: colors.primary.withOpacity(0.4),
                    ),
                  ),
                  child: controller.selectedImage == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              size: 36,
                              color: colors.primary.withOpacity(0.8),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Upload item',
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.file(
                            controller.selectedImage!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),

                /// Remove Image Button
                if (controller.selectedImage != null)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: controller.removeImage,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.55),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Bottom Sheet (Theme-aware)
  void _showPicker(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library, color: colors.primary),
                title: const Text('Gallery'),
                onTap: () {
                  Get.back();
                  controller.pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt, color: colors.primary),
                title: const Text('Camera'),
                onTap: () {
                  Get.back();
                  controller.pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
