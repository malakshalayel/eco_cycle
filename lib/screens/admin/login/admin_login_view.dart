import 'package:eco_cycle/screens/admin/login/admin_login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdminLoginView extends StatelessWidget {
  const AdminLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminLoginController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFF2ECC71),
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      'EcoCycle Admin',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Secure administrator access',
                      style: TextStyle(fontSize: 14.sp, color: Colors.white70),
                    ),
                    SizedBox(height: 32.h),

                    // Card
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Email
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          TextField(
                            onChanged: controller.onEmailChanged,
                            decoration: InputDecoration(
                              hintText: 'admin@ecocycle.com',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14.sp,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 14.h,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 16.h),

                          // Password
                          Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          TextField(
                            obscureText: true,
                            onChanged: controller.onPasswordChanged,
                            decoration: InputDecoration(
                              hintText: 'Enter Your Password',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14.sp,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 14.h,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black87,
                            ),
                          ),

                          SizedBox(height: 20.h),

                          // Error
                          if (controller.errorMessage != null)
                            Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: Text(
                                controller.errorMessage!,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),

                          // Button
                          SizedBox(
                            height: 48.h,
                            child: ElevatedButton(
                              onPressed:
                                  controller.isFormValid &&
                                      !controller.isLoading
                                  ? controller.login
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: controller.isFormValid
                                    ? const Color(0xFF2ECC71) // أخضر
                                    : Colors.grey.shade300, // رمادي
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                elevation: controller.isFormValid ? 2 : 0,
                              ),
                              child: controller.isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Sign In',
                                      style: TextStyle(
                                        color: controller.isFormValid
                                            ? Colors.white
                                            : Colors.grey,
                                      ),
                                    ),
                            ),
                          ),

                          SizedBox(height: 16.h),

                          // Back
                          TextButton(
                            onPressed: controller.backToUserApp,
                            child: const Text(
                              '← Back to User App',
                              style: TextStyle(color: Color(0xFF2ECC71)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
