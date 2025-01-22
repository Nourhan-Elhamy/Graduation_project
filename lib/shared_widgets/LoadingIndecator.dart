import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';

class LoedingIndecator extends StatelessWidget {
  const LoedingIndecator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.blue,
      ),
    );
  }
}
