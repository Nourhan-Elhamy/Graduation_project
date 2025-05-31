import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'package:graduation_project/features/auth/data/controller/auth_cubit.dart';
import 'package:graduation_project/features/auth/data/controller/auth_cubit_states.dart';
import 'package:graduation_project/features/auth/data/repos/auth_repo.dart';
import 'package:graduation_project/features/auth/login/successful_resetpass_screen.dart';
import '../../../core/utils/app_colors.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String code;

  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
    _codeController.text = widget.code;
  }

  void _showMessage(String message, {Color bgColor = Colors.black}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style:  TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        backgroundColor: bgColor.withOpacity(0.9),
        behavior: SnackBarBehavior.floating,
        margin:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthRepository()),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            _showMessage(state.message, bgColor: Colors.green);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const ChangedPassSucessfullyScreen(),
              ),
            );
          } else if (state is AuthFailure) {
            _showMessage(state.error, bgColor: Colors.red);
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Reset Password',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 30.sp,
                  color: AppColors.blue,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.all(16.0.r),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(AppImages.resetPassword),
                       SizedBox(height: 20.h),
                      _buildLabel("Email"),
                      SizedBox(height: 8.h),
                      _buildInputField(
                        controller: _emailController,
                        hintText: 'Enter your email',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }
                          if (!value.contains('@') || !value.contains('.')) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      _buildLabel("Verification Code"),
                       SizedBox(height: 8.h),
                      _buildInputField(
                        controller: _codeController,
                        hintText: 'Enter verification code',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Code is required";
                          }
                          if (value.length < 4) {
                            return "Invalid code";
                          }
                          return null;
                        },
                      ),
                     SizedBox(height: 20.h),
                      _buildLabel("New Password"),
                      SizedBox(height: 8.h),
                      _buildInputField(
                        controller: _passwordController,
                        hintText: 'Enter new password',
                        obscureText: !_isPasswordVisible,
                        suffixIcon: _buildVisibilityIcon(
                          _isPasswordVisible,
                          () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                        ),
                        validator: (value) => value!.length < 6
                            ? "Password must be at least 6 characters"
                            : null,
                      ),
                       SizedBox(height: 40.h),
                      GestureDetector(
                        onTap: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().resetPassword(
                                        email: _emailController.text.trim(),
                                        code: _codeController.text.trim(),
                                        password: _passwordController.text.trim(),
                                      );
                                }
                              },
                        child: Container(
                          width: double.infinity,
                          height: 59.h,
                          decoration: BoxDecoration(
                            color: AppColors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                :  Text(
                                    "Reset Password",
                                    style: TextStyle(color: Colors.white, fontSize: 24.sp),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text) =>
      Text(text, style: TextStyle(fontSize: 16.sp));

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
        contentPadding:  EdgeInsets.symmetric(horizontal: 15.w),
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
