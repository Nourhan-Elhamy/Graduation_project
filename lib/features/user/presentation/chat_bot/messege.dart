import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/utils/app_colors.dart';

// ignore: must_be_immutable
class Messege extends StatelessWidget {
  final bool sender; // true => user, false => bot
  final String text;

  const Messege({super.key, required this.sender, required this.text});

  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end, // عشان الصورة تنزل تحت
        mainAxisAlignment:
        sender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!sender)
            Padding(
              padding: EdgeInsets.only(right: 6.w),
              child: Image.asset(
                'assets/images/3x/Mask group (1).png',
                width: 30.w,
                height: 30.h,
              ),
            ),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: sender ? AppColors.blue :  AppColors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft:
                  sender ? Radius.circular(20) : Radius.circular(0),
                  bottomRight:
                  sender ? Radius.circular(0) : Radius.circular(20),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: sender ? Colors.white : Colors.black87,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
