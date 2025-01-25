import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/shared_widgets/custom_button.dart';

import '../../../../core/utils/app_images.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title Text
            const Text(
              "Select your account \ntype.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff00A3E0),
                fontWeight: FontWeight.w400,
                fontSize: 36,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            // User Option
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Image.asset(
                  AppImages.patientIcon,
                ),
                title: const Text(
                  "User",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff00A3E0),
                  ),
                ),
                subtitle: const Text(
                  "Register as a user so you can find pharmacies and purchase drugs.",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                onTap: () {},
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff00A3E0), width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Image.asset(
                  AppImages.pharmacyIcon,
                ),
                title: const Text(
                  "Pharmacy",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff00A3E0),
                  ),
                ),
                subtitle: const Text(
                  "Register as a pharmacy so you can sell and manage your drugs on the app.",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                onTap: () {},
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                title: 'Continue',
                color: AppColors.blue,
                textcolor: AppColors.white,
                onPressed: () {},
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? "),
                Text(
                  "Sign in",
                  style: TextStyle(color: Color(0xff00A3E0), fontSize: 16),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
