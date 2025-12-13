import 'package:eco_cycle/constants/app_colors.dart';
import 'package:eco_cycle/styles/text_style.dart';
import 'package:eco_cycle/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column( 
        children: [ 
          Image.asset(login),
          SizedBox(height: 20.h,),
Text("Start the journey to a better earth" , style: AppTextStyles.body),
SizedBox(height: 20.h,),
RichText(
  
  text: TextSpan( 
  children: [
TextSpan( 
   text: "Reduce. Reuse. Recycle", 
  style: AppTextStyles.small,
) , 
TextSpan( 
  text: " Repeat.", 
  style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
)
  ],
 
) , 

) , 
SizedBox(height: 40.h,),
Text("Join EcoCycle today!" , style: AppTextStyles.h2),
SizedBox(height: 120.h,),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 40.0),
  child: ElevatedButton(
    onPressed: (){}, 
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      padding: EdgeInsets.symmetric( vertical: 15.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r)
      )
    ),
     child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
       children: [
          SvgPicture.asset(googleLogo),
          SizedBox(width: 10.w,),
         Text("Sign In With Google" , style: AppTextStyles.button.copyWith(color: Colors.white),),
       ],
     )
     ),
) , 
SizedBox(height: 20.h,),

RichText(text: TextSpan( 
  children:  [ 
    TextSpan( 
      text:  "login as admin? ",
      style: AppTextStyles.small
    ), 
    TextSpan( 
      text: "Admin",
      style: AppTextStyles.small.copyWith( fontWeight: FontWeight.bold, decoration: TextDecoration.underline)
    )
  ]
))
        ],
      ),
    );
  }   }