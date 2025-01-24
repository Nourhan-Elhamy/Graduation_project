import 'package:flutter/material.dart';

import 'product_list.dart';

class ProductViewGrid extends StatelessWidget {
  const ProductViewGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 0.1,
        mainAxisSpacing: 5,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return ProductList(icon: Icons.favorite_border_outlined);
      },
    );
  }
}
