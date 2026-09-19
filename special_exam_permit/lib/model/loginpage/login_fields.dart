import 'package:flutter/material.dart';

import 'package:special_exam_permit/model/loginpage/login_validator.dart';
import 'package:special_exam_permit/screens/special_exam_landing/um_theme.dart';

class LoginEmailField extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;

  const LoginEmailField({
    super.key,
    required this.controller,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      enabled: !isLoading,
      validator: LoginValidator.email,

      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'Enter your email',

        prefixIcon: const Icon(Icons.email_outlined, color: UMTheme.maroon),

        filled: true,
        fillColor: Colors.grey.shade50,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: UMTheme.maroon, width: 2),
        ),
      ),
    );
  }
}

class LoginPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final bool obscurePassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onSubmitted;

  const LoginPasswordField({
    super.key,
    required this.controller,
    required this.isLoading,
    required this.obscurePassword,
    required this.onTogglePassword,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscurePassword,
      enabled: !isLoading,
      validator: LoginValidator.password,

      onFieldSubmitted: (_) {
        if (!isLoading) {
          onSubmitted();
        }
      },

      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',

        prefixIcon: const Icon(Icons.lock_outline, color: UMTheme.maroon),

        suffixIcon: IconButton(
          onPressed: isLoading ? null : onTogglePassword,
          color: UMTheme.maroon,
          icon: Icon(
            obscurePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
        ),

        filled: true,
        fillColor: Colors.grey.shade50,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: UMTheme.maroon, width: 2),
        ),
      ),
    );
  }
}
