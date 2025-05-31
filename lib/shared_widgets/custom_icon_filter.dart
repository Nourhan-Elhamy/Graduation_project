import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/utils/app_colors.dart';

class CustomIconFilter extends StatelessWidget {
  const CustomIconFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 5.w),
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: AppColors.blue,
          border: Border.all(
            color: Colors.transparent,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: IconButton(
          icon: const Icon(Icons.filter_alt),
          color: AppColors.white,
          onPressed: () {},
        ),
      ),
    );
  }
}
