import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/features/user/presentation/home.dart';
import 'package:graduation_project/shared_widgets/custom_button.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/2x/checkoutimage.png"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                CustomButton(
                  title: "back to home",
                  color: AppColors.blue,
                  textcolor: AppColors.white,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (C) {
                      return HomeGround();
                    }));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
