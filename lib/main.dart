import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'features/splash/presentation/views/splash_screen.dart';

void main() {
  runApp(

      const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: AppColors.lightTheme,
    );
  }
}
