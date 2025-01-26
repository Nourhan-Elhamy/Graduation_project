import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/utils/appfonts.dart';
import '../../user/presentation/home.dart';
import '../sign_up/user_signup_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  Future<void> _login() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    // Check if username or password is empty
    if (username.isEmpty || password.isEmpty) {
      // Show a message if fields are empty
      _showMessage("Please fill in both username and password.");
      return;
    }

    // Navigate to HomeGround if both fields are filled
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeGround()),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Image.asset(
              AppImages.logo,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "UserName",
                style: TextStyle(fontFamily: AppFonts.creteround),
              ),
            ),
            const SizedBox(height: 5),
            _buildInputField(
              controller: _usernameController,
              hintText: 'UserName',
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Password",
                style: TextStyle(fontFamily: AppFonts.creteround),
              ),
            ),
            const SizedBox(height: 5),
            _buildInputField(
              controller: _passwordController,
              hintText: 'Password',
              obscureText: !_isPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Forgot password?",
                style: TextStyle(
                  color: AppColors.blue,
                  fontFamily: AppFonts.creteround,
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _login,
              child: Container(
                width: double.infinity,
                height: 59,
                decoration: BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Image.asset(AppImages.divider),
            const SizedBox(height: 10),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 59,
                  child: Image.asset(AppImages.google),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 59,
                  child: Image.asset(AppImages.facebook),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account yet? ",
                      style: TextStyle(
                        fontFamily: AppFonts.creteround,
                        color: const Color(0xff455A64),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (c) => RegistrationForm()),
                        );
                      },
                      child: Text(
                        "Register here",
                        style: TextStyle(
                          color: AppColors.blue,
                          fontFamily: AppFonts.creteround,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      width: double.infinity,
      height: 59,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

