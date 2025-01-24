import 'package:flutter/material.dart';
import 'package:graduation_project/features/user/presentation/tabs/Home_tab/Categori_screen/care/care_view.dart';
import 'package:graduation_project/features/user/presentation/tabs/Home_tab/hom_widget.dart/CategoryItem.dart';
import 'package:graduation_project/features/user/presentation/tabs/Home_tab/Categori_screen/offares/offares_view.dart';

import '../Categori_screen/Drugs/Drug_view.dart';
import '../Categori_screen/articl/article_category.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 13,
        mainAxisSpacing: 13,
      ),
      children: [
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DrugView(),
                ),
              );
            },
            child: const Categoryitem(
                image: 'assets/images/medical.png', label: 'Drugs')),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CareView(),
              ),
            );
          },
          child: const Categoryitem(
              image: 'assets/images/Personal Care Icon.png', label: 'Care'),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ArticleCategory(),
              ),
            );
          },
          child: const Categoryitem(
              image: 'assets/images/Articles Icon.png', label: 'Articles'),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OffaresView(),
              ),
            );
          },
          child: const Categoryitem(
              image: 'assets/images/label-tag-01.png', label: 'Offares'),
        ),
      ],
    );
  }
}
