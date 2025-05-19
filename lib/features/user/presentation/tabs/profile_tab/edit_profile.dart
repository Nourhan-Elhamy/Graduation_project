import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/shared_widgets/custom_button.dart';
import 'package:graduation_project/shared_widgets/custom_text_filde.dart';
import 'package:graduation_project/shared_widgets/LocationDisplayWidget.dart';
import 'package:graduation_project/features/user/data/repos/profile_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../../../../../shared_widgets/custom_icon_camera.dart';
import 'controller/profile_cubit.dart';
import 'controller/profile_states.dart';

class EditProfilePage extends StatefulWidget {
  final String userName;
  final String email;
  final String location;
  final String phoneNumber;
  final String? profileImagePath;
  final String? gender;

  const EditProfilePage({
    super.key,
    required this.userName,
    required this.email,
    required this.location,
    this.profileImagePath,
    required this.phoneNumber,
    this.gender,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? profileImagePath;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String selectedGender = '';
  String currentLocation = '';

  @override
  void initState() {
    super.initState();
    profileImagePath = widget.profileImagePath;
    nameController.text = widget.userName;
    phoneNumberController.text = widget.phoneNumber;
    emailController.text = widget.email;
    currentLocation = widget.location;
    selectedGender = widget.gender ?? '';
  }

  Future<String> _getAccessTokenAsync() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access') ?? '';
  }

  Future<String> _saveImageToLocal(String imagePath) async {
    try {
      // Get the application documents directory
      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedPath = path.join(directory.path, fileName);

      // Copy the image to app's local storage
      final File originalFile = File(imagePath);
      if (await originalFile.exists()) {
        await originalFile.copy(savedPath);

        // Save the path to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('profileImage', savedPath);

        return savedPath;
      } else {
        return imagePath;
      }
    } catch (e) {
      return imagePath;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => ProfileCubit(ProfileRepository()),
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            Navigator.pop(context, {
              'profileImage': profileImagePath,
              'userName': nameController.text,
              'email': emailController.text,
              'location': currentLocation,
              'phoneNumber': phoneNumberController.text,
              'gender': selectedGender,
            });
          }
          if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Scaffold(
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
                          backgroundImage: profileImagePath != null &&
                                  profileImagePath!.isNotEmpty
                              ? (profileImagePath!.startsWith('http')
                                  ? NetworkImage(profileImagePath!)
                                      as ImageProvider
                                  : FileImage(File(profileImagePath!)))
                              : null,
                          backgroundColor: AppColors.continerColor,
                          child: profileImagePath == null ||
                                  profileImagePath!.isEmpty
                              ? Icon(Icons.person, size: screenWidth * 0.1)
                              : null,
                        ),

                        // Add a debug text to show the image path

                        CustomIconCamera(
                          onImageSelected: (path) async {
                            if (path != null) {
                              final savedPath = await _saveImageToLocal(path);
                              setState(() {
                                profileImagePath = savedPath;
                              });
                            }
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
                      hintText: "Phone Number",
                      controller: phoneNumberController),
                  SizedBox(height: screenHeight * 0.02),
                  const Text(
                    "Location",
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    children: [
                      Expanded(
                        child: LocationDisplayWidget(
                          onLocationChanged: (newLocation) {
                            setState(() {
                              currentLocation = newLocation;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        icon: Icon(Icons.edit_location_alt,
                            color: AppColors.blue),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              final controller =
                                  TextEditingController(text: currentLocation);
                              return AlertDialog(
                                title: Text("Enter Address"),
                                content: CustomTextFilde(
                                  hintText: "Enter your address",
                                  controller: controller,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        currentLocation = controller.text;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text("Save"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  const Text(
                    "Gender",
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Male'),
                          value: 'male',
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value!;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Female'),
                          value: 'female',
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Builder(
                    builder: (context) => CustomButton(
                      title: "Save",
                      color: AppColors.blue,
                      textcolor: AppColors.white,
                      onPressed: () async {
                        final accessToken = await _getAccessTokenAsync();
                        context.read<ProfileCubit>().updateProfile(
                              accessToken: accessToken,
                              name: nameController.text,
                              gender: selectedGender,
                              phone: phoneNumberController.text,
                              address: currentLocation,
                            );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
