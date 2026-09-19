import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:special_exam_permit/Student/dashboard.dart';
import 'package:special_exam_permit/model/loginpage/login_error_handler.dart';
import 'package:special_exam_permit/model/loginpage/login_service.dart';
import 'package:special_exam_permit/model/loginpage/login_validator.dart';
import 'package:special_exam_permit/model/loginpage/login_widgets.dart';
import 'package:special_exam_permit/register.dart';
import 'package:special_exam_permit/screens/special_exam_landing/um_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final LoginService _loginService = LoginService();

  bool obscurePassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final role = await _loginService.login(
        email: emailController.text,
        password: passwordController.text,
      );

      if (!mounted || role == null) {
        return;
      }

      if (role == 'admin') {
        Navigator.pushReplacementNamed(context, '/admin-dashboard');
      } else if (role == 'student') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      _showMessage(LoginErrorHandler.firebaseMessage(e));
    } catch (e) {
      if (!mounted) return;

      _showMessage(LoginErrorHandler.generalMessage(e));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _forgotPassword() {
    Navigator.pushNamed(context, '/reset-password');
  }

  void _toRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Register()),
    );
  }

  void _backToStudentPortal() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UMTheme.maroon,

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),

            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),

              child: Card(
                elevation: 6,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(28),

                  child: Form(
                    key: _formKey,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,

                      children: [
                        const LoginHeader(),

                        const SizedBox(height: 30),

                        LoginEmailField(
                          controller: emailController,
                          validator: LoginValidator.email,
                        ),

                        const SizedBox(height: 20),

                        LoginPasswordField(
                          controller: passwordController,
                          obscurePassword: obscurePassword,
                          validator: LoginValidator.password,
                          onToggle: () {
                            if (!isLoading) {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            }
                          },
                          onSubmitted: _login,
                        ),

                        const SizedBox(height: 8),

                        ForgotPasswordButton(
                          isLoading: isLoading,
                          onPressed: _forgotPassword,
                        ),

                        const SizedBox(height: 12),

                        LoginButton(isLoading: isLoading, onPressed: _login),

                        const SizedBox(height: 20),

                        RegisterSection(
                          isLoading: isLoading,
                          onPressed: _toRegister,
                        ),

                        const SizedBox(height: 4),

                        BackToStudentPortal(
                          isLoading: isLoading,
                          onPressed: _backToStudentPortal,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
