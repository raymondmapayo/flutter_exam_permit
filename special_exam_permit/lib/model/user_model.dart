class UserModel {
  final String uid;
  final String email;
  final String role;
  final String studentName;
  UserModel({
    required this.uid,
    required this.email,
    required this.role,
    required this.studentName,
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> data) {
    return UserModel(
      uid: uid,
      email: data['email'] ?? '',
      role: data['role'] ?? '',
      studentName: data['studentName'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'email': email, 'role': role, 'studentName': studentName};
  }
}
