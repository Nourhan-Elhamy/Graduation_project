import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/utils/app_colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            CircularProgressIndicator(
              color: AppColors.blue,
            ),
            SizedBox(height: 16),
            Text("Please wait, processing the image..."),
          ],
        ),
      ),
    );
  }
}
