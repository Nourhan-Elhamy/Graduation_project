import 'package:flutter/material.dart';
import 'package:graduation_project/features/user/presentation/tabs/Home_tab/hom_widget.dart/CategoryItem.dart';
import 'package:graduation_project/features/user/presentation/tabs/Home_tab/offares/offares_view.dart';

import '../Drugs/Drug_view.dart';

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
        Categoryitem(
            image: 'assets/images/Personal Care Icon.png', label: 'Care'),
        Categoryitem(
            image: 'assets/images/Articles Icon.png', label: 'Articles'),
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
