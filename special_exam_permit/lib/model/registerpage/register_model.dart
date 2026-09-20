class RegisterModel {
  final String studentId;
  final String studentName;
  final String courseYear;
  final String email;
  final String password;
  final String confirmPassword;

  RegisterModel({
    required this.studentId,
    required this.studentName,
    required this.courseYear,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  bool get isEmpty =>
      studentId.isEmpty ||
      studentName.isEmpty ||
      courseYear.isEmpty ||
      email.isEmpty ||
      password.isEmpty ||
      confirmPassword.isEmpty;

  bool get isValidEmail {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  bool get isValidPassword => password.length >= 6;

  bool get passwordsMatch => password == confirmPassword;
}
