import 'package:eco_cycle/services/language_services.dart';
import 'package:eco_cycle/services/theme_services.dart';
import 'package:eco_cycle/widgets/app_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import '../../constants/app_colors.dart';
import 'profile_controller.dart';
import 'package:eco_cycle/services/theme_services.dart';
import 'package:eco_cycle/widgets/app_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const AppAppBar(
        title: "Profile",
        withBorder: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 60.h),

            /// Avatar
            CircleAvatar(
              radius: 60.r,
              backgroundColor: theme.cardColor,
              backgroundImage: controller.avatarUrl.isNotEmpty
                  ? NetworkImage(controller.avatarUrl)
                  : null,
              child: controller.avatarUrl.isEmpty
                  ? Icon(Icons.person, size: 40.sp, color: colorScheme.primary)
                  : null,
            ),

            SizedBox(height: 24.h),

            /// Name
            _InfoCard(
              icon: Icons.person,
              text: controller.name,
            ),

            SizedBox(height: 15.h),

            /// Email
            _InfoCard(
              icon: Icons.email,
              text: controller.email,
            ),

            SizedBox(height: 20.h),

            /// Theme Toggle
            _InfoCard(
              onTap: () => ThemeServices().switchTheme(),
              icon: Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              text: Get.isDarkMode ? 'Light Mode' : 'Dark Mode',
            ),

            SizedBox(height: 20.h),
_InfoCard(
  icon: Icons.language,
  text: 'Language',
  onTap: () => _showLanguageSheet(context),
),
            SizedBox(height: 20.h),

            /// Logout
            _ActionCard(
              title: 'Logout',
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isDanger
                ? colorScheme.error.withOpacity(0.4)
                : colorScheme.primary.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isDanger ? colorScheme.error : colorScheme.primary,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDanger ? colorScheme.error : null,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: theme.iconTheme.color,
            ),
          ],
        ),
      ),
    );
  }
}
class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const _InfoCard({
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: colorScheme.primary.withOpacity(0.15),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: colorScheme.primary),
            SizedBox(width: 12.w),
            Text(
              text,
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

void _showLanguageSheet(BuildContext context) {
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;

  showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: theme.cardColor,
    builder: (_) {
      return Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            /// Title
            Text(
              'Select Language',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 12.h),
            Divider(color: Colors.grey.withOpacity(0.3)),

            /// Arabic
            _LanguageItem(
              title: 'العربية',
              value: 'ar',
            ),

            /// English
            _LanguageItem(
              title: 'English',
              value: 'en',
            ),
          ],
        ),
      );
    },
  );
}
class _LanguageItem extends StatelessWidget {
  final String title;
  final String value;

  const _LanguageItem({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final currentLang = Get.locale?.languageCode ?? 'en';
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        LanguageServices().changeLanguage(value);
        Get.back(); // close sheet
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: currentLang,
              onChanged: (_) {
                LanguageServices().changeLanguage(value);
                Get.back();
              },
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
