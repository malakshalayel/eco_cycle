import 'package:eco_cycle/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../history_controller.dart';
import 'history_status_badge.dart';

class HistoryItemCard extends StatelessWidget {
  final HistoryItem item;

  const HistoryItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Color(0XFF2ECC71).withOpacity(0.8)),
        
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(
                  item.image,
                  width: 70.w,
                  height: 50.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${item.quantity} ',
                      style: TextStyle(
                        fontSize: 13.sp,
                         fontWeight: FontWeight.w600,
                      ),
                    ),
                     SizedBox(height: 4.h),
                    Text(
                      ' ${item.date}',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              HistoryStatusBadge(status: item.status),
            ],
          ),

          // Approved points
          if (item.status == SubmissionStatus.approved)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '+${item.points} points',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

          // Rejected note
          if (item.status == SubmissionStatus.rejected && item.note != null)
            Container(
              margin: EdgeInsets.only(top: 10.h),
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Color(0xFFFF3D00)),
              ),
              child: Text(
                item.note!,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Color(0xFFFF3D00),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
