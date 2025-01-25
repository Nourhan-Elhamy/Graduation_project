import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // استيراد حزمة http
import 'dart:convert'; // لتحويل JSON

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/appfonts.dart';
import '../../../core/utils/app_images.dart';
import '../../user/presentation/home.dart';
import '../sign_up/user_signup_screen.dart'; // استيراد صفحة التسجيل

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _usernameError;
  String? _passwordError;

  // دالة لتسجيل الدخول
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://carecapsole.runasp.net/login'), // رابط API لتسجيل الدخول
        headers: {
          'Content-Type': 'application/json', // تحديد نوع المحتوى كـ JSON
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // تحويل JSON إلى Map
      } else {
        return {'error': 'Failed to login: ${response.statusCode}'};
      }
    } catch (e) {
      return {'error': 'Failed to login: $e'};
    }
  }

  // دالة للتحقق من البيانات والدخول
  void _validateAndLogin() async {
    setState(() {
      _usernameError = _usernameController.text.isEmpty ? 'Username cannot be empty' : null;
      _passwordError = _passwordController.text.isEmpty ? 'Password cannot be empty' : null;
    });

    // التحقق من البيانات
    if (_usernameError == null && _passwordError == null) {
      final email = _usernameController.text;
      final password = _passwordController.text;

      // استدعاء دالة login
      final result = await login(email, password);

      if (result.containsKey('error')) {
        // في حالة حدوث خطأ أثناء تسجيل الدخول
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['error']),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        // إذا تم تسجيل الدخول بنجاح
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeGround()), // توجيه لصفحة الرئيسية
        );
      }
    } else {
      // لو في أخطاء في التحقق من البيانات
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields correctly!'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
            Container(
              width: double.infinity,
              height: 59,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'UserName',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  errorText: _usernameError,
                ),
              ),
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
            Container(
              width: double.infinity,
              height: 59,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Password',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  errorText: _passwordError,
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
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Forgot password?",
                style: TextStyle(
                    color: AppColors.blue, fontFamily: AppFonts.creteround),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _validateAndLogin, // استدعاء الدالة عند الضغط
              child: Container(
                width: double.infinity,
                height: 59,
                decoration: BoxDecoration(
                  color: Colors.blue,
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
      ),
    );
  }
}