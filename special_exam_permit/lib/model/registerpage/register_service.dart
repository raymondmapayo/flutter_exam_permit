import 'package:firebase_auth/firebase_auth.dart';
import 'package:special_exam_permit/model/registerpage/register_model.dart';
import 'package:special_exam_permit/service/auth_service.dart';

class RegisterService {
  final AuthService _authService = AuthService();

  Future<String?> register(RegisterModel data) async {
    if (data.isEmpty) {
      return 'Please complete all fields.';
    }

    if (!data.isValidEmail) {
      return 'Please enter a valid email address.';
    }

    if (!data.isValidPassword) {
      return 'Password must be at least 6 characters.';
    }

    if (!data.passwordsMatch) {
      return 'Passwords do not match.';
    }

    try {
      await _authService.createWithEmailAndPassword(
        data.email,
        data.password,
        data.confirmPassword,
        data.studentId,
        data.studentName,
        data.courseYear,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'This email is already registered.';

        case 'invalid-email':
          return 'Please enter a valid email address.';

        case 'weak-password':
          return 'The password is too weak.';

        default:
          return e.message ?? 'Registration failed.';
      }
    } catch (e) {
      return 'Something went wrong: $e';
    }
  }
}
