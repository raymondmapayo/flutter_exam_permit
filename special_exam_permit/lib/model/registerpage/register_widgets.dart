import 'package:flutter/material.dart';

import 'package:special_exam_permit/screens/special_exam_landing/um_theme.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.person_add_alt_1_outlined,
          size: 55,
          color: UMTheme.maroon,
        ),

        const SizedBox(height: 15),

        const Text(
          'Create an Account',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: UMTheme.maroon,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Register as a student to access the Student Portal.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        ),
      ],
    );
  }
}

class RegisterTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isLoading;
  final bool obscureText;
  final VoidCallback? onToggle;
  final String? Function(String?)? validator;

  const RegisterTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.isLoading,
    this.obscureText = false,
    this.onToggle,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: !isLoading,
      obscureText: obscureText,
      validator: validator,

      decoration: InputDecoration(
        labelText: label,

        prefixIcon: Icon(icon, color: UMTheme.maroon),

        suffixIcon: onToggle == null
            ? null
            : IconButton(
                onPressed: isLoading ? null : onToggle,
                color: UMTheme.maroon,
                icon: Icon(
                  obscureText
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

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const RegisterButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,

      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,

        style: ElevatedButton.styleFrom(
          backgroundColor: UMTheme.maroon,
          foregroundColor: Colors.white,
          elevation: 2,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,

                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text(
                'REGISTER',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}

class RegisterLoginSection extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const RegisterLoginSection({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Text(
          'Already have an account?',
          style: TextStyle(color: Colors.grey.shade600),
        ),

        TextButton(
          onPressed: isLoading ? null : onPressed,

          child: const Text(
            'Login',
            style: TextStyle(
              color: UMTheme.maroon,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class RegisterBackToStudentPortal extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const RegisterBackToStudentPortal({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: isLoading ? null : onPressed,

      icon: const Icon(Icons.arrow_back, size: 18),

      label: const Text('Back to Student Portal'),

      style: TextButton.styleFrom(foregroundColor: UMTheme.maroon),
    );
  }
}
