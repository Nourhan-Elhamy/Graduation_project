import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/shared_widgets/custom_button.dart';
import 'package:graduation_project/shared_widgets/custom_text_filde.dart';

import '../../../../../shared_widgets/custom_icon_camera.dart';

class EditProfilePage extends StatefulWidget {
  final String userName;
  final String email;
  final String location;
  final String phoneNumber;
  final String? profileImagePath;

  const EditProfilePage({
    super.key,
    required this.userName,
    required this.email,
    required this.location,
    this.profileImagePath,
    required this.phoneNumber,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? profileImagePath;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    profileImagePath = widget.profileImagePath;
    nameController.text = widget.userName;
    phoneNumberController.text = widget.phoneNumber;
    emailController.text = widget.email;
    locationController.text = widget.location;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: screenWidth * 0.25,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context, {});
          },
          child: Text(
            "Cancel",
            style: TextStyle(
              color: const Color(0xff9C4400),
              fontSize: screenHeight * 0.025,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.2,
                      backgroundImage: profileImagePath != null
                          ? FileImage(File(profileImagePath!))
                          : null,
                      backgroundColor: AppColors.continerColor,
                    ),
                    CustomIconCamera(
                      onImageSelected: (path) {
                        setState(() {
                          profileImagePath = path;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              const Text(
                "Full Name",
                style: TextStyle(color: Colors.blueGrey),
              ),
              CustomTextFilde(
                  hintText: "Full Name", controller: nameController),
              SizedBox(height: screenHeight * 0.02),
              const Text(
                "Email Address",
                style: TextStyle(color: Colors.blueGrey),
              ),
              CustomTextFilde(
                  hintText: "Email Address", controller: emailController),
              SizedBox(height: screenHeight * 0.02),
              const Text(
                "Phone Number",
                style: TextStyle(color: Colors.blueGrey),
              ),
              CustomTextFilde(
                  hintText: "Phone Number", controller: phoneNumberController),
              SizedBox(height: screenHeight * 0.02),
              const Text(
                "Location",
                style: TextStyle(color: Colors.blueGrey),
              ),
              CustomTextFilde(
                  hintText: "Location", controller: locationController),
              SizedBox(height: screenHeight * 0.1),
              CustomButton(
                title: "Save",
                color: AppColors.blue,
                textcolor: AppColors.white,
                onPressed: () {
                  // عندما يتم الضغط على زر Save، يتم إرسال البيانات المحدثة
                  Navigator.pop(context, {
                    'profileImage': profileImagePath,
                    'userName': nameController.text,
                    'email': emailController.text,
                    'location': locationController.text,
                    "phoneNumber": phoneNumberController.text
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
