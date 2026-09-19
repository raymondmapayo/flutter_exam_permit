import 'package:flutter/material.dart';

import 'package:special_exam_permit/screens/special_exam_landing/um_theme.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: UMTheme.goldLight.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.lock_person_outlined,
            color: UMTheme.maroon,
            size: 38,
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          'Login Portal',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: UMTheme.maroon,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          'Sign in to access your account.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 14, height: 1.4),
        ),
      ],
    );
  }
}

class LoginEmailField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const LoginEmailField({
    super.key,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: validator,

      decoration: InputDecoration(
        labelText: 'Email Address',

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
  final bool obscurePassword;
  final VoidCallback onToggle;
  final VoidCallback onSubmitted;
  final String? Function(String?)? validator;

  const LoginPasswordField({
    super.key,
    required this.controller,
    required this.obscurePassword,
    required this.onToggle,
    required this.onSubmitted,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscurePassword,
      textInputAction: TextInputAction.done,
      validator: validator,

      onFieldSubmitted: (_) {
        onSubmitted();
      },

      decoration: InputDecoration(
        labelText: 'Password',

        prefixIcon: const Icon(Icons.lock_outline, color: UMTheme.maroon),

        suffixIcon: IconButton(
          onPressed: onToggle,
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

class LoginButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const LoginButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,

      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,

        style: ElevatedButton.styleFrom(
          backgroundColor: UMTheme.maroon,
          foregroundColor: Colors.white,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
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
                'LOGIN',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
      ),
    );
  }
}

class ForgotPasswordButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const ForgotPasswordButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,

      child: TextButton(
        onPressed: isLoading ? null : onPressed,

        child: const Text(
          'Forgot Password?',
          style: TextStyle(color: UMTheme.maroon, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class RegisterSection extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const RegisterSection({
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
          "Don't have an account?",
          style: TextStyle(color: Colors.grey.shade600),
        ),

        TextButton(
          onPressed: isLoading ? null : onPressed,

          child: const Text(
            'Register',
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

class BackToStudentPortal extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const BackToStudentPortal({
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
