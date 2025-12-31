import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/app_colors.dart';
import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'profile',
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: (){},
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 60.h),

            /// Avatar
            CircleAvatar(
              radius: 60.r,
              backgroundImage: controller.avatarUrl.isNotEmpty
                  ? NetworkImage(controller.avatarUrl)
                  : null,
              backgroundColor: Colors.white,
            ),

            SizedBox(height: 24.h),

            /// Name
            _InfoCard(icon: Icons.person, text: controller.name),

            SizedBox(height: 15.h),

            /// Email
            _InfoCard(icon: Icons.email, text: controller.email),

            SizedBox(height: 20.h),

            /// Logout
            _ActionCard(
              title: 'LogOut',
              icon: Icons.logout,
              onTap: controller.logout,
            ),

            SizedBox(height: 15.h),

            /// Delete Account
            _ActionCard(
              title: 'Delete Account',
              icon: Icons.delete,
              isDanger: true,
              onTap: controller.deleteAccount,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isDanger;
  final VoidCallback onTap;

  const _ActionCard({
    required this.title,
    required this.icon,
    required this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: isDanger ? Colors.grey.shade300 : Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(101, 112, 109, 109),
              blurRadius: 10.r,
              offset: Offset(0, 10.h),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isDanger ? Colors.grey.shade700 : Colors.black,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(title, style: TextStyle(fontSize: 13.sp)),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoCard({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(101, 112, 109, 109),
            blurRadius: 10.r,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 18),
          SizedBox(width: 12.w),
          Text(text, style: TextStyle(fontSize: 16.sp)),
        ],
      ),
    );
  }
}
