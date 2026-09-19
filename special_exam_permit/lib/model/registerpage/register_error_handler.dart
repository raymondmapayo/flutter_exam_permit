import 'package:firebase_auth/firebase_auth.dart';

class RegisterErrorHandler {
  static String firebaseMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already registered.';

      case 'invalid-email':
        return 'Please enter a valid school email address.';

      case 'weak-password':
        return 'The password is too weak.';

      case 'user-disabled':
        return 'This account has been disabled.';

      case 'operation-not-allowed':
        return 'Email and password registration is not enabled.';

      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';

      default:
        return e.message ?? 'Registration failed.';
    }
  }

  static String generalMessage(Object error) {
    return error.toString().replaceFirst('Exception: ', '');
  }
}
