import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/features/user/presentation/tabs/profile_tab/refill_reminder.dart';

import 'edit_profile.dart';

class ProfileCategori extends StatefulWidget {
  const ProfileCategori({Key? key}) : super(key: key);

  @override
  State<ProfileCategori> createState() => _ProfileCategoriState();
}

class _ProfileCategoriState extends State<ProfileCategori> {
  String? profileImagePath;
  String userName = "UserName";
  String email = "@email";
  String location = "11204.5761 Tanta";
  String phoneNumber = "01000010000";

  // Method to navigate to EditProfilePage
  void navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    ).then((updatedData) {
      // Update the data after returning from EditProfilePage
      if (updatedData != null) {

        setState(() {
          profileImagePath = updatedData['profileImage'];
          userName = updatedData['userName'];
          email = updatedData['email'];
          location = updatedData['location'];
          phoneNumber = updatedData['phoneNumber'];
        });
      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.1),

              // Display Profile Image
              CircleAvatar(
                radius: screenWidth * 0.2,
                backgroundImage: profileImagePath != null
                    ? FileImage(File(profileImagePath!))
                    : null, // Check if the profile image is available
                child: profileImagePath == null
                    ? Icon(Icons.person, size: screenWidth * 0.1)
                    : null, // Placeholder if no image
              ),

              SizedBox(height: screenHeight * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: screenWidth*0.05),
                  GestureDetector(
                    onTap: () {
                      navigateToPage(context, EditProfilePage(
                        userName: userName,
                        email: email,
                        location: location,
                        profileImagePath: profileImagePath,
                        phoneNumber: phoneNumber,
                      ));
                    },
                    child: Icon(Icons.edit_outlined),
                  ),
                ],
              ),
              SizedBox(height: screenHeight*0.01),
              Text(
                email,
                style: TextStyle(fontSize: screenWidth * 0.05),
              ),
              Text(
                phoneNumber,
                style: TextStyle(fontSize: screenWidth * 0.05),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth*0.04,vertical: screenWidth*0.01),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: AppColors.blue),
                        SizedBox(width: screenWidth*0.01),
                        Text(
                          location,
                          style: TextStyle(color: AppColors.blue),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.07),
              Divider(),
              BuildListTile(
                label: "Personal Information",
                image: Image.asset("assets/images/2x/personIcon.png"),
                onTap: () {
                  navigateToPage(context, EditProfilePage(
                    userName: userName,
                    email: email,
                    location: location,
                    profileImagePath: profileImagePath, phoneNumber: phoneNumber,
                  ));
                },
              ),
              BuildListTile(
                label: "Change Password",
                image: Image.asset("assets/images/2x/union-1.png"),
                onTap: () {

                },
              ),
              BuildListTile(
                label: "My Orders",
                image: Image.asset("assets/images/2x/orders.png"),
                onTap: () {

                },
              ),
              BuildListTile(
                label: "Refill Reminder",
                image: Image.asset("assets/images/2x/retail.png"),
                onTap: () {
                  navigateToPage(context, RefillReminder());
                },
              ),
              BuildListTile(
                label: "Language Preferences",
                image: Image.asset("assets/images/2x/globe.png"),
                onTap: () {

                },
              ),
              BuildListTile(
                label: "Report an Issue",
                image: Image.asset("assets/images/2x/report.png"),
                onTap: () {

                },
              ),
              BuildListTile(
                label: "About us",
                image: Image.asset("assets/images/2x/About Icon.png"),
                onTap: () {

                },
              ),
              // Add other items here...
            ],
          ),
        ],
      ),
    );
  }
}

class BuildListTile extends StatelessWidget {
  const BuildListTile({super.key, required this.label, required this.image, required this.onTap});
  final String label;
  final Image image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
          ),
        ),
        leading: image,
        onTap: onTap,
      ),
    );
  }
}
