class UserModel {
  final String uid;
  final String email;
  final String role;
  final String studentName;
  final String courseYear;
  final String studentId;
  UserModel({
    required this.uid,
    required this.email,
    required this.role,
    required this.studentName,
    required this.studentId,
    required this.courseYear,
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> data) {
    return UserModel(
      uid: uid,
      email: data['email'] ?? '',
      role: data['role'] ?? '',
      studentId: data['studentId'] ?? '',
      courseYear: data['courseYear'] ?? '',
      studentName: data['studentName'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'role': role,
      'studentName': studentName,
      'courseYear': courseYear,
      'studentId': studentId,
    };
  }
}
