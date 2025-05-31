import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/utils/app_colors.dart';

class ArticleCtegory extends StatelessWidget {
  final String image;
  final String titel;
  final String head;
  const ArticleCtegory({
    super.key,
    required this.image,
    required this.titel,
    required this.head,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.blue,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            child: Image.asset(
              image,
            ),
          ),
          Divider(
            color: AppColors.blue,
            thickness: 2,
            height: 0,
          ),
           SizedBox(
            height: 10.h,
          ),
          Padding(
            padding:  EdgeInsets.only(left: 8.w, right: 8.w),
            child: Text(
              titel,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.w, right: 8.w),
            child: Text(
              head,
              maxLines: 4,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }
}
