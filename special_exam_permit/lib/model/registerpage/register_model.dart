class RegisterModel {
  final String email;
  final String password;
  final String confirmPassword;

  RegisterModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  bool get isEmpty =>
      email.isEmpty || password.isEmpty || confirmPassword.isEmpty;

  bool get isValidEmail => email.contains('@');

  bool get isValidPassword => password.length >= 6;

  bool get passwordsMatch => password == confirmPassword;
}
