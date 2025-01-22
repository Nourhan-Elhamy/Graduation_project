import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';

class CustomIconFilter extends StatelessWidget {
  const CustomIconFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.blue,
          border: Border.all(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: IconButton(
          icon: Icon(Icons.filter_alt),
          color: AppColors.white,
          onPressed: () {},
        ),
      ),
    );
    ;
  }
}
