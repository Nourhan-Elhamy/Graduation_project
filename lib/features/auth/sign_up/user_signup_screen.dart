import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'Get_Started.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  RegistrationFormState createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isChecked = false;
  bool _isLoading = false;

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please accept the Terms and Privacy Policy")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration Successful!")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const GetStartScreen()),
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
                suffixIcon: _buildVisibilityIcon(
                  _isPasswordVisible,
                      () => setState(() => _isPasswordVisible = !_isPasswordVisible),
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
                suffixIcon: _buildVisibilityIcon(
                  _isConfirmPasswordVisible,
                      () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                ),
                validator: (value) => value != _passwordController.text ? "Passwords do not match" : null,
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                title: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(text: "I agree to the ", style: TextStyle(fontSize: 16, color: Colors.black)),
                      TextSpan(text: "Terms ", style: TextStyle(fontSize: 16, color: Colors.blue)),
                      TextSpan(text: "and ", style: TextStyle(fontSize: 16, color: Colors.black)),
                      TextSpan(text: "Privacy Policy", style: TextStyle(fontSize: 16, color: Colors.blue)),
                    ],
                  ),
                ),
                value: _isChecked,
                onChanged: (value) => setState(() => _isChecked = value ?? false),
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
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      "Sign UP",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Image.asset(AppImages.divider),
              const SizedBox(height: 20),
              Image.asset(AppImages.google, width: 352, height: 59),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Text(text, style: const TextStyle(fontSize: 16));

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
      ),
      validator: validator,
    );
  }

  Widget _buildVisibilityIcon(bool isVisible, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
      onPressed: onPressed,
    );
  }
}
