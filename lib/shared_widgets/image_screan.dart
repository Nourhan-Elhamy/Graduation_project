import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/app_colors.dart';

class ImageResultScreen extends StatelessWidget {
  final String imagePath;
  final String resultText;

  const ImageResultScreen({
    Key? key,
    required this.imagePath,
    required this.resultText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('result',style: TextStyle(color: AppColors.blue),),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.0.r),
        child: Column(
          children: [
            Image.file(
              File(imagePath),
              width: double.infinity,
              height: 300.h,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.h),
            Text(
              resultText,
              style:  TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
