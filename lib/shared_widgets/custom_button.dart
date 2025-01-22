import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.onPressed,
      required this.title,
      required this.color,
      required this.textcolor,
      this.fontSize = 24});
  final void Function()? onPressed;
  final Color color;
  final String title;
  final Color textcolor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: MediaQuery.of(context).size.height * 0.07,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: onPressed,
      color: color,
      child: Text(
        title,
        style: TextStyle(color: textcolor, fontSize: fontSize),
      ),
    );
  }
}
