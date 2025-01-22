import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/features/user/presentation/search_class/home_search.dart';

class ContainerSearch extends StatelessWidget {
  const ContainerSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeSearch(),
          ),
        );
      },
      child: Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.continerColor.withOpacity(0.2),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.search),
              SizedBox(
                width: 5,
              ),
              Text("Search"),
            ],
          ),
        ),
      ),
    );
  }
}
