import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

class AppColors {
  static Color blue = const Color(0xff00A3E0);
  static Color iconColor = Color(0xffA0C1D6);
  static Color dividerColor = Color(0xff9747FF);

  static Color white = Colors.white;
  static Color continerColor = const Color(0xffa0c1d6);
  static Color idcatorCircle = const Color(0xffa0c1d699);
  static ThemeData lightTheme = ThemeData(
      iconTheme: IconThemeData(
        color: AppColors.iconColor, // تغيير لون السهم إلى اللون المحدد
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xff00A3E0),
        unselectedItemColor: Color(0xff00a3e0d),
      ),
      textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)));
}
