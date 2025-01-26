import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/features/auth/login/user_login_screen.dart';
import 'package:graduation_project/features/onboarding/presentation/views/role_selection_page.dart';
import 'package:graduation_project/shared_widgets/custom_button.dart';

import '../../../../core/utils/app_images.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.iustration),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                const Text(
                  "Get Started",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff00A3E0),
                      fontWeight: FontWeight.w400,
                      fontSize: 36),
                ),
                const Text(
                    "Join carecapsule today and enjoy convenient access to pharmacies across different locations. \nStart now!",
                    textAlign: TextAlign.center),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                CustomButton(
                  title: "Login to existing account",
                  color: AppColors.blue,
                  textcolor: AppColors.white,
                  onPressed: () {
                    Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (c){
                        return LoginPage();
                      })
                    );
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomButton(
                    title: "Sign Up",
                    color: AppColors.white,
                    textcolor: AppColors.blue,
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (c) {
                        return const RoleSelectionScreen();
                      }));
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
