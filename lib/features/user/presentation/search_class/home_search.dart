import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/services/Api_service.dart';
import 'package:graduation_project/features/user/presentation/search_class/news_search_delegate.dart';

class HomeSearch extends StatelessWidget {
  const HomeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: NewsSearchDelegate(apiService: ApiService(Dio())),
              );
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
    );
  }
}
