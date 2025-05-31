// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/shared_widgets/LoadingIndecator.dart';

class DrugList extends StatelessWidget {
  final IconData icon;

  const DrugList({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: CachedNetworkImage(
                imageUrl:
                    'https://www.iisertvm.ac.in/assets/images/placeholder.jpg',
                width: 130.w,
                height: 130.h,
                fit: BoxFit.cover,
                placeholder: (_, __) => const LoedingIndecator(),
                errorWidget: (_, __, ___) =>
                    const Icon(Icons.image_not_supported_outlined),
              ),
            ),
            Positioned(
              top: 8.h,
              right: 8.w,
              child: Icon(
                icon,
                size: 24.sp,
                color: AppColors.blue,
              ),
            ),
          ],
        ),
       SizedBox(height: 1.h),
        SizedBox(
          height: 20.h,
          width: 100.w,
          child: Text(
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            'Antinal 200 mg - 24 Capsules',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 14.sp, color: Colors.black),
          ),
        ),
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            children: [
              TextSpan(
                text: "Egp: ",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 16.sp, color: Colors.black),
              ),
              TextSpan(
                text: "60",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
