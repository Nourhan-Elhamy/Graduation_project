import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';

import 'article_body.dart';

class ArticleCategory extends StatelessWidget {
  const ArticleCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Cancer Guides',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 30, color: AppColors.blue),
        ),
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: ArticleBody(),
    );
  }
}
