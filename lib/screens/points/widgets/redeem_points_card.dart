import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../points_controller.dart';
import '../../../constants/app_colors.dart';

class RedeemPointsCard extends GetView<PointsController> {
  const RedeemPointsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            'Redeem Points',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),

          SizedBox(height: 12.h),

          /// Card
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.6),
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Enter Points
                const _FieldLabel('Enter Points:'),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Expanded(
                      child: _InputField(
                        controller: controller.pointsController,
                        hint: '200 Points',
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GetBuilder<PointsController>(
                      builder: (_) => Container(
                        height: 40.h,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'cash value: ${controller.cashValue.toStringAsFixed(2)}\$',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 14.h),

                /// IBAN
                const _FieldLabel('Enter IBAN:'),
                SizedBox(height: 6.h),
                _InputField(
                  controller: controller.ibanController,
                  hint: 'PS92 PIBC 0000 01234 5678 9012',
                ),

                SizedBox(height: 14.h),

                /// BIC / SWIFT
                const _FieldLabel('Enter BIC/SWIFT Address:'),
                SizedBox(height: 6.h),
                _InputField(
                  controller: controller.swiftController,
                  hint: 'PIBCPS22XXX',
                ),

                SizedBox(height: 18.h),

                /// Convert Button
                Center(
                  child: SizedBox(
                    width: 140.w,
                    height: 42.h,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'convert',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
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

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const _InputField({required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary.withOpacity(0.6)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          isDense: true,
        ),
        style: TextStyle(fontSize: 11.sp),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
    );
  }
}
