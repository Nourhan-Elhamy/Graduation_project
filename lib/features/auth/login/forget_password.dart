import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/auth/login/vertify_code_screen.dart';
import '../data/controller/auth_cubit.dart';
import '../data/controller/auth_cubit_states.dart';
import '../data/repos/auth_repo.dart';
import '../../../core/utils/app_colors.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _showMessage(String message, {Color bgColor = Colors.black}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: bgColor.withOpacity(0.9),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            String? code;
            if (state.message.contains('code:')) {
              final codeMatch =
                  RegExp(r'code: (\d+)').firstMatch(state.message);
              if (codeMatch != null) {
                code = codeMatch.group(1);
              }
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VerifyCodeScreen(
                  initialCode: code,
                ),
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
                'Forget Password',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 30,
                  color: AppColors.blue,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(AppImages.forgetPasswordImage),
                        Text(
                          "Please Enter Your Email Address To\nRecieve a Code.",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 55),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Email Address"),
                        ),
                        const SizedBox(height: 10),
                        _buildInputField(
                          controller: emailController,
                          hintText: "Email Address",
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1),
                        GestureDetector(
                          onTap: isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthCubit>().forgetPassword(
                                          email: emailController.text.trim(),
                                        );
                                  }
                                },
                          child: Container(
                            width: double.infinity,
                            height: 59,
                            decoration: BoxDecoration(
                              color: AppColors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : const Text(
                                      "Send",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 24),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
      height: 59,
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
