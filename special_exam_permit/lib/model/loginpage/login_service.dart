import 'package:special_exam_permit/model/user_model.dart';
import 'package:special_exam_permit/service/auth_service.dart';

class LoginService {
  final AuthService _authService = AuthService();

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    final result = await _authService.signInWithEmailAndPassword(
      email.trim().toLowerCase(),
      password.trim(),
    );

    if (result == null || result.user == null) {
      return null;
    }

    final uid = result.user!.uid;

    final userModel = await _authService.getUser(uid);

    if (userModel == null) {
      await _authService.logout();

      throw Exception(
        'User information not found. Please contact the administrator.',
      );
    }

    if (userModel.role == 'admin' || userModel.role == 'student') {
      return userModel;
    }

    // INVALID ROLE
    await _authService.logout();

    throw Exception('Invalid user role. Please contact the administrator.');
  }
}
