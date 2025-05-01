import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';

class WishCategori extends StatelessWidget {
  const WishCategori({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Wish List",
            style: TextStyle(color: AppColors.blue, fontSize: 30),
          ),
        ),
        body: Image.asset("assets/images/favorite_image.png"));
  }
}
