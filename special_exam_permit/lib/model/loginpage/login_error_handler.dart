import 'package:firebase_auth/firebase_auth.dart';

class LoginErrorHandler {
  static String firebaseMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
        return 'Incorrect email or password.';

      case 'user-not-found':
        return 'No account found with this email.';

      case 'wrong-password':
        return 'Incorrect password.';

      case 'invalid-email':
        return 'Please enter a valid email address.';

      case 'user-disabled':
        return 'This account has been disabled.';

      case 'too-many-requests':
        return 'Too many login attempts. Please try again later.';

      default:
        return e.message ?? 'Login failed.';
    }
  }

  static String generalMessage(Object error) {
    return error.toString().replaceFirst('Exception: ', '');
  }
}
