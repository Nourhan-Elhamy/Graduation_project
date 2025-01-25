// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../../../core/utils/app_images.dart';
import '../../../onboarding/presentation/views/onboarding_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller1;
  late AnimationController controller2;
  late Animation<double> fadeIn1;
  late Animation<double> fadeIn2;

  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    fadeIn1 = Tween<double>(begin: 0.0, end: 1.0).animate(controller1);

    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    fadeIn2 = Tween<double>(begin: 0.0, end: 1.0).animate(controller2);

    controller1.forward();

    Future.delayed(const Duration(seconds: 2), () {
      controller2.forward();
    });
    controller2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            right: MediaQuery.of(context).size.width * 0.2,
            child: AnimatedBuilder(
              animation: fadeIn1,
              builder: (context, child) {
                return Opacity(
                  opacity: fadeIn1.value,
                  child: Image.asset(AppImages.splashrightside,
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.height * 0.15),
                );
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            left: MediaQuery.of(context).size.width * 0.2,
            child: AnimatedBuilder(
              animation: fadeIn2,
              builder: (context, child) {
                return Opacity(
                  opacity: fadeIn2.value,
                  child: Center(
                      child: Image.asset(AppImages.splashleftside,
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.height * 0.15)),
                );
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.46,
            left: MediaQuery.of(context).size.width * 0.2,
            child: AnimatedBuilder(
                animation: fadeIn2,
                builder: (context, child) {
                  return Opacity(
                    opacity: fadeIn2.value,
                    child: Center(
                        child: Image.asset(AppImages.carecapsulelogo,
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.2)),
                  );
                }),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }
}
