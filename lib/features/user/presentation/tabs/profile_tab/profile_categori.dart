import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/features/auth/login/forget_password.dart';
import 'package:graduation_project/features/auth/login/user_login_screen.dart';
import 'package:graduation_project/features/user/presentation/tabs/profile_tab/refill_reminder.dart';
import 'package:graduation_project/features/auth/data/repos/auth_repo.dart';
import 'package:graduation_project/features/user/presentation/tabs/profile_tab/report_issue_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_profile.dart';

class ProfileCategori extends StatefulWidget {
  const ProfileCategori({super.key});

  @override
  State<ProfileCategori> createState() => _ProfileCategoriState();
}

class _ProfileCategoriState extends State<ProfileCategori> {
  String? profileImagePath;
  String userName = "";
  String email = "";
  String location = "";
  String phoneNumber = "";
  String? gender;
  final AuthRepository _authRepository = AuthRepository();
  bool isLoading = true;
  String currentLocation = '';

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name') ?? '';
      email = prefs.getString('email') ?? '';
      location = prefs.getString('location') ?? '';
      phoneNumber = prefs.getString('phone') ?? '';
      profileImagePath = prefs.getString('profileImage');
      gender = prefs.getString('gender');
    });
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    setState(() {
      isLoading = true;
    });

    final result = await _authRepository.getProfile();

    result.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      },
      (response) {
        if (response['status'] == 'success' && response['data'] != null) {
          final userData = response['data'];
          setState(() {
            userName = userData['name'] ?? userName;
            email = userData['email'] ?? email;
            location = userData['address'] ?? location;
            phoneNumber = userData['phone'] ?? phoneNumber;
            profileImagePath = userData['image'] ?? profileImagePath;
            gender = userData['gender'] ?? gender;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to load profile data')),
          );
        }
      },
    );

    setState(() {
      isLoading = false;
    });
  }

  void navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    ).then((updatedData) async {
      if (updatedData != null) {
        final prefs = await SharedPreferences.getInstance();
        
        setState(() {
          location = updatedData['location'] ?? location;
          userName = updatedData['userName'] ?? userName;
          email = updatedData['email'] ?? email;
          phoneNumber = updatedData['phoneNumber'] ?? phoneNumber;
          profileImagePath = updatedData['profileImage'] ?? profileImagePath;
          gender = updatedData['gender'] ?? gender;
        });

        // Save all updated data to SharedPreferences
        await prefs.setString('location', location);
        await prefs.setString('name', userName);
        await prefs.setString('email', email);
        await prefs.setString('phone', phoneNumber);
        await prefs.setString('profileImage', profileImagePath ?? '');
        await prefs.setString('gender', gender ?? '');
        
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

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
                backgroundImage: profileImagePath != null && profileImagePath!.isNotEmpty
                    ? (profileImagePath!.startsWith('http')
                    ? NetworkImage(profileImagePath!) as ImageProvider
                    : FileImage(File(profileImagePath!)))
                    : null,
                backgroundColor: AppColors.continerColor,
                child: profileImagePath == null || profileImagePath!.isEmpty
                    ? Icon(Icons.person, size: screenWidth * 0.1)
                    : null,
              ),

              // Add a debug text to show the image path


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
                  SizedBox(width: screenWidth * 0.05),
                  GestureDetector(
                    onTap: () {
                      navigateToPage(
                        context,
                        EditProfilePage(
                          userName: userName,
                          email: email,
                          location: location,
                          profileImagePath: profileImagePath,
                          phoneNumber: phoneNumber,
                          gender: gender,
                        ),
                      );
                    },
                    child: Icon(Icons.edit_outlined),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
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
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenWidth * 0.01),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: AppColors.blue),
                        SizedBox(width: screenWidth * 0.01),
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
                  navigateToPage(
                      context,
                      EditProfilePage(
                        userName: userName,
                        email: email,
                        location: location,
                        profileImagePath: profileImagePath,
                        phoneNumber: phoneNumber,
                        gender: gender,
                      ));
                },
              ),
              BuildListTile(
                label: "Change Password",
                image: Image.asset("assets/images/2x/union-1.png"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (c){
                    return ForgetPasswordScreen();
                  }));
                },
              ),
              BuildListTile(
                label: "My Orders",
                image: Image.asset("assets/images/2x/orders.png"),
                onTap: () {},
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
                onTap: () {},
              ),
              BuildListTile(
                label: "Report an Issue",
                image: Image.asset("assets/images/2x/report.png"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (c){
                    return ReportIssueScreen();
                  }));
                },
              ),
              BuildListTile(
                label: "Log Out",
                image: Image.asset("assets/images/logout.png",height: 38,),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (c){
                    return LoginPage();
                  }));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BuildListTile extends StatelessWidget {
  const BuildListTile(
      {super.key,
      required this.label,
      required this.image,
      required this.onTap});
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
