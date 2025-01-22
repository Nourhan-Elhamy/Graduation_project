import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:graduation_project/core/utils/app_colors.dart';

class ImageCarouselWithCustomIndicator extends StatefulWidget {
  @override
  _ImageCarouselWithCustomIndicatorState createState() =>
      _ImageCarouselWithCustomIndicatorState();
}

class _ImageCarouselWithCustomIndicatorState
    extends State<ImageCarouselWithCustomIndicator> {
  List<String> imgList = [
    'assets/images/Frame 74 (1).png',
    'assets/images/Frame 74 (3).png',
    'assets/images/Frame 74.png',
  ];

  int _currentIndex = 0;

  // Custom indicator dots
  Widget _buildIndicator(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      height: 7,
      width: 7,
      decoration: BoxDecoration(
        color: _currentIndex == index
            ? AppColors.blue
            : AppColors.idcatorCircle.withOpacity(0.6),
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: imgList.map((imgUrl) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imgUrl),
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 170,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            imgList.length,
            (index) => _buildIndicator(index),
          ),
        ),
      ],
    );
  }
}
