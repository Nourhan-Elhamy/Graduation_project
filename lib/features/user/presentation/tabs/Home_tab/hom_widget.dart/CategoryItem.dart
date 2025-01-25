// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';

class Categoryitem extends StatelessWidget {
  const Categoryitem({super.key, required this.image, required this.label});
  final String image;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Container(
          width: 77,
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.blue.withOpacity(0.10),
            border: Border.all(
              color: Colors.transparent,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: (Image.asset(
            image,
            width: 60,
            height: 60,
          )),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          label,
          softWrap: true,
        )
      ],
    );
  }
}
