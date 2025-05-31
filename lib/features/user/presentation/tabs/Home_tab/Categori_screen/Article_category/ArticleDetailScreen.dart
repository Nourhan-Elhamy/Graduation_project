// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/user/data/models/article/article.dart';
import '../../../../../../../core/utils/app_colors.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: AppColors.grey,)),
        title: Text(article.name,style: TextStyle(color: AppColors.blue),),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.all(20.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.name,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold,color: AppColors.grey),
            ),
            SizedBox(height: 20.h),
            Text(
              article.description,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
