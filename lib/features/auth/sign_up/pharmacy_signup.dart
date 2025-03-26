import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class PharmacySignUpScreen extends StatefulWidget {
  @override
  _PharmacySignUpScreenState createState() => _PharmacySignUpScreenState();
}

class _PharmacySignUpScreenState extends State<PharmacySignUpScreen> {
  final _pharmacyNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _businessEmailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _isPasswordVisible = false; // لإظهار/إخفاء كلمة المرور
  bool _isConfirmPasswordVisible = false; // لإظهار/إخفاء تأكيد كلمة المرور

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  bool _isValidEmail(String email) {
    // التحقق من صحة البريد الإلكتروني
    final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegex.hasMatch(email);
  }

  Future<void> _signUp() async {
    try {
      final response = await http.post(
        Uri.parse('http://carecapsole.runasp.net/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'pharmacyName': _pharmacyNameController.text,
          'ownerName': _ownerNameController.text,
          'businessEmail': _businessEmailController.text,
          'password': _passwordController.text,
          'confirmPassword': _confirmPasswordController.text,
        }),
      );

      print("API Response: ${response.body}");
    } catch (e) {
      print("API Error: $e");
    }
  }

  void _handleSignUp() async {
    // التحقق من أن جميع الحقول مملوءة
    if (_pharmacyNameController.text.isEmpty ||
        _ownerNameController.text.isEmpty ||
        _businessEmailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showMessage("Please fill in all fields.");
      return;
    }

    // التحقق من صحة البريد الإلكتروني
    if (!_isValidEmail(_businessEmailController.text)) {
      _showMessage("Enter a valid email.");
      return;
    }

    // التحقق من تطابق كلمات المرور
    if (_passwordController.text != _confirmPasswordController.text) {
      _showMessage("Passwords do not match.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await _signUp();

    // الانتقال إلى الصفحة التالية
    //Navigator.pushReplacement(
     // context,
     // MaterialPageRoute(builder: (context) => UploadDocumentsScreen()),
   // );

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel("Pharmacy Name"),
              SizedBox(height: 8),
              _buildInputField(
                controller: _pharmacyNameController,
                hintText: 'Enter Pharmacy Name',
              ),
              const SizedBox(height: 20),

              _buildLabel("Owner's Name"),
              _buildInputField(
                controller: _ownerNameController,
                hintText: 'Enter Owner\'s Name',
              ),
              const SizedBox(height: 20),

              _buildLabel("Business Email"),
              _buildInputField(
                controller: _businessEmailController,
                hintText: 'Enter Business Email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              _buildLabel("Password"),
              _buildPasswordField(
                controller: _passwordController,
                hintText: 'Enter Password',
                isPasswordVisible: _isPasswordVisible,
                onToggleVisibility: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              const SizedBox(height: 20),

              _buildLabel("Confirm Password"),
              _buildPasswordField(
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                isPasswordVisible: _isConfirmPasswordVisible,
                onToggleVisibility: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
              ),
              const SizedBox(height: 20),

              GestureDetector(
                onTap: _handleSignUp,
                child: Container(
                  width: double.infinity,
                  height: 59,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
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
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        ),
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool isPasswordVisible,
    required VoidCallback onToggleVisibility,
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
        obscureText: !isPasswordVisible,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.blue,
            ),
            onPressed: onToggleVisibility,
          ),
        ),
      ),
    );
  }
}