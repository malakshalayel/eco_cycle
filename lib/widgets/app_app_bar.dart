import 'package:eco_cycle/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool withBorder;
  final String? backgroundImage; // ✅ صورة اختيارية
  final double imageOpacity;

   AppAppBar({
    super.key,
    required this.title,
    this.withBorder = true,
    this.backgroundImage,
    this.imageOpacity = 0.4, // شفافية texture
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PreferredSize(
      preferredSize: Size.fromHeight(74.h),
      child: AppBar(
        elevation: 0,
        centerTitle: true,

        // 🔹 لو في صورة ما نستخدم لون
        backgroundColor:
            backgroundImage == null ? theme.colorScheme.primary : Colors.transparent,

        flexibleSpace:  Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(withBorder ? 16.r : 0.r),
          ),
                  image: DecorationImage(
                    
                    image: AssetImage(ecoBackground),
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.repeat, // مهم للـ texture
                    colorFilter: ColorFilter.mode(
                      theme.colorScheme.primary.withOpacity(imageOpacity),
                      BlendMode.srcATop,
                    ),
                  ),
                ),
              )
          ,

        title: Text(
          title,
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(withBorder ? 16.r : 0.r),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(74.h);
}
