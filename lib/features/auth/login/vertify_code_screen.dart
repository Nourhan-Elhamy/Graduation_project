import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'package:graduation_project/features/auth/login/reset_pass_screen.dart';
import '../../../core/utils/app_colors.dart';
import '../data/controller/auth_cubit.dart';
import '../data/controller/auth_cubit_states.dart';
import '../data/repos/auth_repo.dart';
import 'package:flutter/services.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String? initialCode;
  
  const VerifyCodeScreen({
    super.key,
    this.initialCode,
  });

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _lastAction = '';
  String? _lastReceivedCode;

  @override
  void initState() {
    super.initState();
    if (widget.initialCode != null) {
      _codeController.text = widget.initialCode!;
    }
  }

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

  void _showCodeDialog(String code) {
    _codeController.text = code;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'verify Code',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Code Requested Successfully',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.blue.withOpacity(0.3)),
                ),
                child: Text(
                  code,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: code));
                      _showMessage('Code Copied !', bgColor: Colors.green);
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text('Copy Code'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                  label: const Text('Close'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (_emailController.text.trim().isEmpty) {
                      _showMessage("PLease enter your emailً", bgColor: Colors.red);
                      return;
                    }
                    _lastAction = 'resend';
                    context.read<AuthCubit>().forgetPassword(
                      email: _emailController.text.trim(),
                    );
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Resend'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.blue,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _onVerify(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _lastAction = 'verify';
      context.read<AuthCubit>().verifyCode(
        email: _emailController.text.trim(),
        code: _codeController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(AuthRepository()),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            _showMessage(state.error, bgColor: Colors.red);
          }
          if (state is AuthSuccess) {
            _showMessage(state.message, bgColor: Colors.green);

            if (_lastAction == 'verify') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => ResetPasswordScreen(
                    email: _emailController.text.trim(),
                    code: _codeController.text.trim(),
                  ),
                ),
              );
            } else if (_lastAction == 'resend' && state.message.contains('code')) {
              // Extract code from the success message if it contains the code
              final codeMatch = RegExp(r'code: (\d+)').firstMatch(state.message);
              if (codeMatch != null) {
                _lastReceivedCode = codeMatch.group(1);
                _showCodeDialog(_lastReceivedCode!);
              }
            }
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Verify Your Email',
                style: TextStyle(
                  color: AppColors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 180,
                      child: Image.asset(AppImages.vertifyPassword, fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Please Verify Code ",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                        fillColor: AppColors.iconColor.withOpacity(0.1),
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Email is required";
                        if (!value.contains('@') || !value.contains('.')) return "Enter a valid email";
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _codeController,
                      decoration: InputDecoration(
                        labelText: "Verification Code",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                        fillColor: AppColors.iconColor.withOpacity(0.1),
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Code is required";
                        if (value.length < 4) return "Invalid code";
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: isLoading ? null : () => _onVerify(context),
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("Verify", style: TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          if (_emailController.text.trim().isEmpty) {
                            _showMessage("Please enter your email first.", bgColor: Colors.red);
                            return;
                          }
                          _lastAction = 'resend';
                          context.read<AuthCubit>().forgetPassword(
                            email: _emailController.text.trim(),
                          );
                        },
                        child: Text("Resend Code", style: TextStyle(color: AppColors.blue)),
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
}