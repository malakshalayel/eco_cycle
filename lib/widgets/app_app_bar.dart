import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
final bool? withBorder ; 
  const AppAppBar({super.key, required this.title , this.withBorder =true});

  @override
  Widget build(BuildContext context) {
final theme = Theme.of(context);
    return 
    
     PreferredSize(
          preferredSize: Size.fromHeight(74.h),
          child: AppBar(
            backgroundColor: theme.colorScheme.primary,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Submit Recyclable',
             style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
            ),
            shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.vertical(
    bottom: Radius.circular(!withBorder!? 16.r : 0.r),
  )  ,
),

          ),
        );

  }

  @override
  Size get preferredSize => const Size.fromHeight(74);
}
