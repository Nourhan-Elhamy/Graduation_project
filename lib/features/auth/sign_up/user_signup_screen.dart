import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'package:graduation_project/core/utils/appfonts.dart';
import 'package:graduation_project/features/auth/get_start/views/get_start_screen.dart';


import '../../../services/user_signup_service.dart'; // استيراد AuthService

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

  final AuthService _authService = AuthService(); // إنشاء كائن من AuthService

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
            fontFamily: AppFonts.creteround,
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
                // Full Name
                _buildLabel("Full Name"),
                const SizedBox(height: 8),
                _buildInputField(
                  controller: _usernameController,
                  hintText: 'Full Name',
                ),
                const SizedBox(height: 20),

                // Email Address
                _buildLabel("Email Address"),
                const SizedBox(height: 8),
                _buildInputField(
                  controller: _emailController,
                  hintText: 'Email Address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Confirm Password
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Checkbox for Terms and Privacy Policy
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
                              fontFamily: AppFonts.creteround,
                              color: Colors.black),
                        ),
                        TextSpan(
                          text: "Terms ",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: AppFonts.creteround,
                              color: Colors.blue),
                        ),
                        TextSpan(
                          text: "and ",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: AppFonts.creteround,
                              color: Colors.black),
                        ),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: AppFonts.creteround,
                              color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Sign Up Button
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate() && _isChecked) {
                      // إرسال بيانات التسجيل إلى الـ API
                      try {
                        final response = await _authService.register(
                          _emailController.text,
                          _passwordController.text,
                        );

                        if (response != null) {
                          // الانتقال إلى الشاشة التالية بعد نجاح التسجيل
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (c) => GetStartScreen()),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Registration Failed: $e')),
                        );
                      }
                    } else if (!_isChecked) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("You must agree to the terms")),
                      );
                    }
                  },
                  child: Container(
                    width: 352,
                    height: 59,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.blue,
                    ),
                    child: Center(
                      child: Text(
                        "Sign UP",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontFamily: AppFonts.creteround,
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

  // Helper widget for field labels
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, fontFamily: AppFonts.creteround),
    );
  }

  // Helper widget for input fields
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