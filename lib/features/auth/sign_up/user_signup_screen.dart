import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/features/auth/login/user_login_screen.dart';

import '../data/controller/auth_cubit.dart';
import '../data/controller/auth_cubit_states.dart';
import '../data/repos/auth_repo.dart';
import 'Get_Started.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(AuthRepository()),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            _showStyledSnackBar(context, state.message, Colors.black);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const GetStartScreen()),
            );
          } else if (state is AuthFailure) {
            final errorMsg = _formatBackendErrors(state.error);
            _showStyledSnackBar(context, errorMsg, Colors.red);
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                'Create Account',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 30,
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
                      validator: (value) =>
                          value!.isEmpty ? "Full Name is required" : null,
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
                        () => setState(
                            () => _isPasswordVisible = !_isPasswordVisible),
                      ),
                      validator: (value) => value!.length < 6
                          ? "Password must be at least 6 characters"
                          : null,
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
                        () => setState(() => _isConfirmPasswordVisible =
                            !_isConfirmPasswordVisible),
                      ),
                      validator: (value) => value != _passwordController.text
                          ? "Passwords do not match"
                          : null,
                    ),
                    const SizedBox(height: 20),
                    CheckboxListTile(
                      controlAffinity:
                          ListTileControlAffinity.leading, // هذه السطر الجديد

                      title: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: "I agree to the ",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black)),
                            TextSpan(
                                text: "Terms ",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.blue)),
                            TextSpan(
                                text: "and ",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black)),
                            TextSpan(
                                text: "Privacy Policy",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.blue)),
                          ],
                        ),
                      ),
                      value: _isChecked,
                      onChanged: (value) =>
                          setState(() => _isChecked = value ?? false),
                      activeColor:
                          AppColors.blue, // لتغيير اللون عند التفعيل إلى الأزرق
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: isLoading
                          ? null
                          : () {
                              if (!_formKey.currentState!.validate()) return;
                              if (!_isChecked) {
                                _showStyledSnackBar(
                                    context,
                                    "Please accept the Terms and Privacy Policy",
                                    Colors.red);
                                return;
                              }
                              context.read<AuthCubit>().register(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    fullName: _usernameController.text.trim(),
                                    address: _addressController.text.trim(),
                                  );
                            },
                      child: Container(
                        width: double.infinity,
                        height: 59,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.blue,
                        ),
                        child: Center(
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(color: Color(0xff455A64)),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) => const LoginPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign in",
                              style: TextStyle(color: AppColors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showStyledSnackBar(
      BuildContext context, String message, Color bgColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Color.fromRGBO(
          bgColor.red,
          bgColor.green,
          bgColor.blue,
          0.9,
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  String _formatBackendErrors(String rawError) {
    try {
      final errorData =
          rawError.contains('{') ? rawError : '{"message":"$rawError"}';
      final parsed = errorData.replaceAll(RegExp(r'[\{\}\[\]"]'), '');
      return parsed.split(':').last.trim();
    } catch (_) {
      return rawError;
    }
  }

  Widget _buildLabel(String text) =>
      Text(text, style: const TextStyle(fontSize: 16));

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
        fillColor: AppColors.iconColor.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
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
