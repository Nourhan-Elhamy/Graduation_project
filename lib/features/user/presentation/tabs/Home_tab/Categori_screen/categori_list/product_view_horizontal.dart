import 'package:flutter/material.dart';

import 'product_list.dart';

class ProductViewHorizontal extends StatelessWidget {
  const ProductViewHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ProductList(
              icon: Icons.add,
            ),
          );
        },
      ),
    );
  }
}
