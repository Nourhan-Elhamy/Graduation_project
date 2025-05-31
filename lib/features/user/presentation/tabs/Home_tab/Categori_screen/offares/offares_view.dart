import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:dotted_line/dotted_line.dart';
class OffaresView extends StatelessWidget {
  const OffaresView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Offers',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 30.sp, color: AppColors.blue), // ريسبونسف
        ),
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: ListView(
        children: [
          DottedLine(
            lineLength: double.infinity,
            lineThickness: 1.0,
            dashLength: 5.0.w, // ريسبونسف
            dashColor: AppColors.dividerColor,
            dashRadius: 0.0,
            dashGapLength: 5.0.w, // ريسبونسف
          ),
          Padding(
            padding: EdgeInsets.all(15.w), // ريسبونسف
            child: Image.asset('assets/images/Frame 74 (1).png'),
          ),
          Padding(
            padding: EdgeInsets.all(15.w), // ريسبونسف
            child: Image.asset('assets/images/Frame 74 (3).png'),
          ),
          Padding(
            padding: EdgeInsets.all(15.w), // ريسبونسف
            child: Image.asset('assets/images/Frame 74.png'),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.h), // ريسبونسف
            child: DottedLine(
              lineLength: double.infinity,
              lineThickness: 1.0,
              dashLength: 5.0.w, // ريسبونسف
              dashColor: AppColors.dividerColor,
              dashRadius: 0.0,
              dashGapLength: 5.0.w, // ريسبونسف
            ),
          ),
        ],
      ),
    );
  }
}
