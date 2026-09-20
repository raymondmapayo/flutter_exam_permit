import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:special_exam_permit/model/registerpage/register_error_handler.dart';
import 'package:special_exam_permit/model/registerpage/register_model.dart';
import 'package:special_exam_permit/model/registerpage/register_service.dart';
import 'package:special_exam_permit/model/registerpage/register_validator.dart';
import 'package:special_exam_permit/model/registerpage/register_widgets.dart';
import 'package:special_exam_permit/screens/special_exam_landing/um_theme.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final RegisterService _registerService = RegisterService();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _studentIdController = TextEditingController();

  final TextEditingController _studentNameController = TextEditingController();

  final TextEditingController _courseYearController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isLoading = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  Future<void> createAccount() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final studentId = _studentIdController.text.trim();

    final studentName = _studentNameController.text.trim();

    final courseYear = _courseYearController.text.trim();

    final email = _emailController.text.trim().toLowerCase();

    final password = _passwordController.text;

    final confirmPassword = _confirmPasswordController.text;

    final data = RegisterModel(
      studentId: studentId,
      studentName: studentName,
      courseYear: courseYear,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    setState(() {
      isLoading = true;
    });

    try {
      final error = await _registerService.register(data);

      if (!mounted) return;

      if (error != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error)));
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully.')),
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(RegisterErrorHandler.firebaseMessage(e))),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(RegisterErrorHandler.generalMessage(e))),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _studentIdController.dispose();
    _studentNameController.dispose();
    _courseYearController.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
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
                        const RegisterHeader(),

                        const SizedBox(height: 30),

                        // STUDENT ID
                        RegisterTextField(
                          controller: _studentIdController,
                          label: 'Student ID',
                          icon: Icons.badge_outlined,
                          isLoading: isLoading,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your Student ID.';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        // FULL NAME
                        RegisterTextField(
                          controller: _studentNameController,
                          label: 'Full Name',
                          icon: Icons.person_outline,
                          isLoading: isLoading,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your full name.';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        // COURSE & YEAR
                        RegisterTextField(
                          controller: _courseYearController,
                          label: 'Course & Year',
                          icon: Icons.school_outlined,
                          isLoading: isLoading,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your course and year.';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        RegisterTextField(
                          controller: _emailController,
                          label: 'Email',
                          icon: Icons.email_outlined,
                          isLoading: isLoading,
                          validator: RegisterValidator.email,
                        ),

                        const SizedBox(height: 20),

                        RegisterTextField(
                          controller: _passwordController,
                          label: 'Password',
                          icon: Icons.lock_outline,
                          isLoading: isLoading,
                          obscureText: obscurePassword,
                          onToggle: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          validator: RegisterValidator.password,
                        ),

                        const SizedBox(height: 20),

                        RegisterTextField(
                          controller: _confirmPasswordController,
                          label: 'Confirm Password',
                          icon: Icons.lock_outline,
                          isLoading: isLoading,
                          obscureText: obscureConfirmPassword,
                          onToggle: () {
                            setState(() {
                              obscureConfirmPassword = !obscureConfirmPassword;
                            });
                          },
                          validator: (value) {
                            return RegisterValidator.confirmPassword(
                              _passwordController.text,
                              value,
                            );
                          },
                        ),

                        const SizedBox(height: 25),

                        RegisterButton(
                          isLoading: isLoading,
                          onPressed: createAccount,
                        ),

                        const SizedBox(height: 20),

                        RegisterLoginSection(
                          isLoading: isLoading,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),

                        const SizedBox(height: 4),

                        RegisterBackToStudentPortal(
                          isLoading: isLoading,
                          onPressed: () {
                            Navigator.pop(context);
                          },
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
