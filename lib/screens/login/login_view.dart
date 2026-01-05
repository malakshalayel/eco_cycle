import 'package:eco_cycle/routes/app_routes.dart';
import 'package:eco_cycle/screens/login/login_controller.dart';
import 'package:eco_cycle/styles/text_style.dart';
import 'package:eco_cycle/utils/assets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          /// Top Image
          Image.asset(login),

          SizedBox(height: 20.h),

          /// Title
          Text(
            "Start the journey to a better earth",
            style: AppTextStyles.body(context),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 20.h),

          /// Subtitle
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Reduce. Reuse. Recycle",
                  style: AppTextStyles.small(context),
                ),
                TextSpan(
                  text: " Repeat.",
                  style: AppTextStyles.body(context).copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 40.h),

          /// CTA
          Text(
            "Join EcoCycle today!",
            style: AppTextStyles.h2(context),
          ),

          SizedBox(height: 90.h),

          /// Google Sign In Button
          GetBuilder<LoginController>(
            builder: (c) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      c.isLoading ? null : controller.signInWithGoogle,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: colors.onPrimary,
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: c.isLoading
                      ? SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: colors.onPrimary,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              googleLogo,
                              height: 20,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              "Sign In With Google",
                              style: AppTextStyles.button(context),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          /// Admin Login Text
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "login as admin? ",
                  style: AppTextStyles.small(context),
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer( 
                    
                  )..onTap = () {
                    Get.toNamed(Routes.ADMIN_LOGIN);
                  },
                  text: "Admin",
                  style: AppTextStyles.small(context).copyWith(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
