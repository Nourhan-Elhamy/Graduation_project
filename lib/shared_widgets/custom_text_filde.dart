import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';

class CustomTextFilde extends StatelessWidget {
  const CustomTextFilde({super.key,  this.hintText,this.icon, this.controller});
  final String? hintText;
  final IconData? icon;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        border: InputBorder.none,
        filled: true,
        fillColor: AppColors.continerColor.withOpacity(0.2),
        focusColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: AppColors.continerColor.withOpacity(0.2), width: 2.0),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: AppColors.continerColor.withOpacity(0.2), width: 2.0),
          borderRadius: BorderRadius.circular(30),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
      ),

    );
  }
}
