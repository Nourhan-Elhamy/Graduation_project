// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'article_ctegory.dart';

class ArticleCategoryView extends StatelessWidget {
  const ArticleCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 13,
        mainAxisSpacing: 13,
      ),
      children: const [
        ArticleCtegory(
          image: 'assets/images/Cofide Image.png',
          titel: 'COVID-19 ',
          head: 'WHO recommends a simplified .....',
        ),
        ArticleCtegory(
          image: 'assets/images/article Image@3x.png',
          titel: 'Antibiotics',
          head: 'Antibiotics include a range of powerful drugs....',
        ),
      ],
    );
  }
}
