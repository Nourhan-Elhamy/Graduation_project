import 'package:flutter/material.dart';
import 'dart:math' as math;

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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    // Responsive height for the button
    final double buttonHeight = screenHeight * 0.07;

    // Responsive border radius - let's make it proportional to button height or screen width
    // Example: 5% of screen width, or 30% of button height
    final double borderRadiusValue = math.min(screenWidth * 0.05, buttonHeight * 0.5); // Cap radius

    // Responsive font size
    // Scale based on screen width, relative to a common design width (e.g., 412)
    // Clamp the font size to avoid it becoming too small or too large.
    final double scaledFontSize = (fontSize * (screenWidth / 412)).clamp(12.0, 30.0);
    final double responsiveFontSize = scaledFontSize * textScaleFactor;


    return MaterialButton(
      minWidth: double.infinity,
      height: buttonHeight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusValue),
      ),
      onPressed: onPressed,
      color: color,
      child: Text(
        title,
        style: TextStyle(color: textcolor, fontSize: responsiveFontSize),
      ),
    );
  }
}
