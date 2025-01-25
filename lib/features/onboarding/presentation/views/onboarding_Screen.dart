// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/shared_widgets/custom_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../data/models/onboarding_model.dart';
import 'get_started.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
            controller: pageController,
            itemCount: onboardingmodel.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(30.0),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(onboardingmodel[index].image),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        Text(
                          onboardingmodel[index].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.blue, fontSize: 36),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        Text(
                          onboardingmodel[index].desc,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        SmoothPageIndicator(
                          controller: pageController,
                          count: onboardingmodel.length,
                          effect: const ExpandingDotsEffect(
                            activeDotColor: Color(0xff00A3E0),
                            dotColor: Colors.grey,
                            dotHeight: 6,
                            dotWidth: 6,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        CustomButton(
                          title: "Continue",
                          color: AppColors.blue,
                          textcolor: AppColors.white,
                          onPressed: () {
                            if (index == onboardingmodel.length - 1) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (c) {
                                return const GetStartedScreen();
                              }));
                            } else {
                              pageController.animateToPage(index + 1,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.linear);
                            }
                          },
                        )
                      ],
                    ),
                  ],
                ),
              );
            }));
  }
}
