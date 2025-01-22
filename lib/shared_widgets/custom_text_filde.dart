import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';

class CustomTextFilde extends StatelessWidget {
  const CustomTextFilde({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          filled: true,
          fillColor: AppColors.continerColor.withOpacity(0.2),
          focusColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.continerColor.withOpacity(0.2), width: 2.0),
            borderRadius: BorderRadius.circular(30),
          ),
          hintText: 'Search',
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
