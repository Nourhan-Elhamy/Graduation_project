import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/utils/services/Api_service.dart';
import 'package:graduation_project/features/user/data/models/article/article.dart';
import 'package:graduation_project/features/user/presentation/tabs/Home_tab/Categori_screen/Article_category/ArticleDetailScreen.dart';

import '../../../../../../../core/utils/app_colors.dart';

class ArticleCategory extends StatefulWidget {
  const ArticleCategory({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ArticleCategoryState createState() => _ArticleCategoryState();
}

class _ArticleCategoryState extends State<ArticleCategory> {
  late Future<List<Article>> articles;

  @override
  void initState() {
    super.initState();
    articles = ApiService(Dio()).getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: AppColors.grey,)),
        centerTitle: true,
        title: Text('Diseases & Conditions',style: TextStyle(color: AppColors.blue,fontSize: 30.sp),),
      ),
      body: FutureBuilder<List<Article>>(
        future: articles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No articles available'));
          }

          final List<Article> articlesList = snapshot.data!;

          return Padding(
            padding: EdgeInsets.only(top: 20.h, left: 30.w),
            child: ListView(
              children: articlesList.map((article) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ArticleDetailScreen(article: article),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0.h),
                    child: Text(
                      article.name,
                      style:
                      Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 20,color: AppColors.grey),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
