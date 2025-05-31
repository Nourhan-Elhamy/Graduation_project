import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
// import 'package:graduation_project/features/user/presentation/search_class/home_search.dart'; // home_search.dart seems unused here
import 'dart:math' as math;

import '../core/utils/services/Api_service.dart';
import '../features/user/presentation/search_class/news_search_delegate.dart';

class ContainerSearch extends StatelessWidget {
  const ContainerSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    // Responsive dimensions for the container
    final double containerWidth = screenWidth * 0.8; // 80% of screen width
    final double containerHeight = screenHeight * 0.07; // 7% of screen height, similar to button

    // Responsive border radius, e.g., half of the container height
    final double borderRadiusValue = containerHeight / 2;

    // Responsive padding, e.g., 2% of container height or width
    final double paddingValue = math.min(containerWidth * 0.03, containerHeight * 0.15);

    // Responsive icon size
    final double iconSize = (containerHeight * 0.4).clamp(18.0, 30.0) * textScaleFactor;

    // Responsive font size
    final double baseFontSize = 16;
    final double scaledFontSize = (baseFontSize * (screenWidth / 412)).clamp(12.0, 22.0);
    final double responsiveFontSize = scaledFontSize * textScaleFactor;

    // Responsive SizedBox width
    final double sizedBoxWidth = screenWidth * 0.02;


    return GestureDetector(
      onTap: () {
        showSearch(
          context: context,
          delegate: NewsSearchDelegate(apiService: ApiService(Dio())),
        );
      },
      child: Container(
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          color: AppColors.continerColor.withOpacity(0.2),
        ),
        child: Padding(
          padding: EdgeInsets.all(paddingValue),
          child: Row(
            children: [
              Icon(Icons.search, size: iconSize),
              SizedBox(
                width: sizedBoxWidth,
              ),
              Text("Search", style: TextStyle(fontSize: responsiveFontSize)),
            ],
          ),
        ),
      ),
    );
  }
}
