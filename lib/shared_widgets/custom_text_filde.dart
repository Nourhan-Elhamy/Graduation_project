import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'dart:math' as math;

class CustomTextFilde extends StatelessWidget {
  const CustomTextFilde({super.key, this.hintText, this.icon, this.controller});
  final String? hintText;
  final IconData? icon;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: controller,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, size: 10),
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.white54,
        focusColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.blue.withOpacity(0.4), width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.blue.withOpacity(0.4), width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
      ),
    );
  }
}
