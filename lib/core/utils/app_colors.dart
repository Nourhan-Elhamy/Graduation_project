// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

class AppColors {
  static Color blue = const Color(0xff00A3E0);
  static Color iconColor =  Color(0xffA0C1D6);
  static Color dividerColor = const Color(0xff9747FF);

  static Color white = Colors.white;
  static Color continerColor = const Color(0xffa0c1d6);
  static Color idcatorCircle = const Color(0xffa0c1d699);
  static ThemeData lightTheme = ThemeData(
    fontFamily: "Crete Round",
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
