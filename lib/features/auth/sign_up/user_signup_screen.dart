import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'package:http/http.dart' as http; // استيراد حزمة http
import 'dart:convert';

import 'Get_Started.dart'; // لتحويل JSON

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isChecked = false;
  bool _isLoading = false; // مؤشر تحميل

  Future<void> _registerUser() async {
    final url = Uri.parse("http://carecapsole.runasp.net/register");

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please accept the Terms and Privacy Policy")),
      );
      return;
    }

    setState(() {
      _isLoading = true; // بدء التحميل
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "username": _usernameController.text.trim(),
          "email": _emailController.text.trim(),
          "password": _passwordController.text,
        }),
      );


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration Successful!")),
      );
    } catch (e) {
      //
    } finally {
      setState(() {
        _isLoading = false; // إيقاف التحميل
      });


      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GetStartScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Create Account',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 24,

            color: AppColors.blue,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel("Full Name"),
                const SizedBox(height: 8),
                _buildInputField(
                  controller: _usernameController,
                  hintText: 'Full Name',
                  validator: (value) => value!.isEmpty ? "Full Name is required" : null,
                ),
                const SizedBox(height: 20),

                _buildLabel("Email Address"),
                const SizedBox(height: 8),
                _buildInputField(
                  controller: _emailController,
                  hintText: 'Email Address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                _buildLabel("Password"),
                const SizedBox(height: 8),
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
                  validator: (value) => value!.length < 6 ? "Password must be at least 6 characters" : null,
                ),
                const SizedBox(height: 20),

                _buildLabel("Confirm Password"),
                const SizedBox(height: 8),
                _buildInputField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: !_isConfirmPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                  validator: (value) => value != _passwordController.text ? "Passwords do not match" : null,
                ),
                const SizedBox(height: 20),

                ListTile(
                  leading: Checkbox(
                    checkColor: AppColors.blue,
                    activeColor: Colors.grey,
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                  ),
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "I agree to the ",
                          style: TextStyle(
                              fontSize: 16,

                              color: Colors.black),
                        ),
                        TextSpan(
                          text: "Terms ",
                          style: TextStyle(
                              fontSize: 16,

                              color: Colors.blue),
                        ),
                        TextSpan(
                          text: "and ",
                          style: TextStyle(
                              fontSize: 16,

                              color: Colors.black),
                        ),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                              fontSize: 16,

                              color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                GestureDetector(
                  onTap: _registerUser,
                  child: Container(
                    width: 352,
                    height: 59,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.blue,
                    ),
                    child: Center(
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white) // مؤشر تحميل
                          : Text(
                        "Sign UP",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,

                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Image.asset(AppImages.divider),
                const SizedBox(height: 20),
                Container(
                  width: 352,
                  height: 59,
                  child: Image.asset(AppImages.google),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Container(
      width: double.infinity,
      height: 59,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          suffixIcon: suffixIcon,
        ),
        validator: validator,
      ),
    );
  }
}