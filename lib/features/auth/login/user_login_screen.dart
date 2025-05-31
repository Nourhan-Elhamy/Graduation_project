import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/auth/login/forget_password.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_images.dart';
import '../../user/presentation/home.dart';
import '../data/controller/auth_cubit.dart';
import '../data/controller/auth_cubit_states.dart';
import '../sign_up/user_signup_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repos/auth_repo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  void _attemptLogin(BuildContext blocContext) {
    final String email = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("Please fill in both email and password.", bgColor: Colors.red);
      return;
    }

    blocContext.read<AuthCubit>().login(email: email, password: password);
  }

  void _showMessage(String message, {Color bgColor = Colors.black}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        backgroundColor: bgColor.withOpacity(0.9),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(AuthRepository()),
      child: Builder(
        builder: (context) {
          return BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                _showMessage(state.error, bgColor: Colors.red);
              } else if (state is LoginSuccess) {
                _showMessage("Login successful", bgColor: Colors.red);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeGround()),
                );
              }
            },
            builder: (context, state) {
              bool isLoading = state is AuthLoading;
              return Scaffold(
                body: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 40.h),
                      Image.asset(AppImages.logo, fit: BoxFit.cover),
                      SizedBox(height: 20.h),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Email"),
                      ),
                      SizedBox(height: 5.h),
                      _buildInputField(
                        controller: _usernameController,
                        hintText: 'Email',
                      ),
                      SizedBox(height: 30.h),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Password"),
                      ),
                       SizedBox(height: 5.h),
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
                      SizedBox(height: 30.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (c) => const ForgetPasswordScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(color: AppColors.blue),
                          ),
                        ),
                      ),
                       SizedBox(height: 20.h),
                      GestureDetector(
                        onTap: isLoading ? null : () => _attemptLogin(context),
                        child: Container(
                          width: double.infinity,
                          height: 59,
                          decoration: BoxDecoration(
                            color: AppColors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                :  Text(
                              "Login",
                              style: TextStyle(color: Colors.white, fontSize: 24.sp),
                            ),
                          ),
                        ),
                      ),
                       SizedBox(height: 10.h),

                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account yet? ",
                            style: TextStyle(color: Color(0xff455A64)),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) => const RegistrationForm(),
                                ),
                              );
                            },
                            child: Text(
                              "Register here",
                              style: TextStyle(color: AppColors.blue),
                            ),
                          ),
                        ],
                      )

                    ],

                  ),
                ),
              );
            },
          );
        },
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
      height: 59.h,
      decoration: BoxDecoration(
        color: AppColors.iconColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
