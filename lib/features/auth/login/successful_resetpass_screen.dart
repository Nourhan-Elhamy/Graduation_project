import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/auth/login/user_login_screen.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_images.dart';

class ChangedPassSucessfullyScreen extends StatelessWidget {
  const ChangedPassSucessfullyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.changedPassword),

               SizedBox(height: 32.h),
              Text(
                'Change Password Successfully!',
                style: TextStyle(
                  color: AppColors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 26.sp,
                ),
                textAlign: TextAlign.center,
              ),
               SizedBox(height: 24.h),
               Text(
                'Your password has been changed successfully.',
                style: TextStyle(fontSize: 16.sp, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
               SizedBox(height: 40.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c){
                      return LoginPage();
                    }));
                  },
                  child:  Text(
                    'Log In',
                    style: TextStyle(fontSize: 20.sp, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}