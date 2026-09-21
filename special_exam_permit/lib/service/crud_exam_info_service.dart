import 'package:cloud_firestore/cloud_firestore.dart';

class CrudExamInfoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ============================================================
  // GET SUBJECTS
  // ============================================================

  Stream<QuerySnapshot> getSubjects() {
    return _firestore
        .collection('exam_subjects')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // ============================================================
  // GET REASONS
  // ============================================================

  Stream<QuerySnapshot> getReasons() {
    return _firestore
        .collection('exam_reasons')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // ============================================================
  // GET EXAM TIMES
  // ============================================================

  Stream<QuerySnapshot> getExamTimes() {
    return _firestore
        .collection('exam_times')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> deleteExamRequest(String documentId) async {
    await _firestore
        .collection('exams_students_resquest')
        .doc(documentId)
        .delete();
  }

  Future<void> updateExamRequest(
    String documentId,
    Map<String, dynamic> data,
  ) async {
    await _firestore
        .collection('exams_students_resquest')
        .doc(documentId)
        .update(data);
  }

  Stream<QuerySnapshot> getExamRequests() {
    return _firestore
        .collection('exams_students_resquest')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> updateExamRequestStatus({
    required String documentId,
    required String status,
  }) async {
    await _firestore
        .collection('exams_students_resquest')
        .doc(documentId)
        .update({'status': status});
  }

  // ============================================================
  // ADD EXAM REQUEST
  // ============================================================

  Future<void> addExamRequest({
    required String studentId,
    required String studentName,
    required String courseYear,
    required String email,
    required String subject,
    required String reason,
    required String examTime,
    required String additionalDetails,
    required String documentUrl,
  }) async {
    await _firestore.collection('exams_students_resquest').add({
      'studentId': studentId.trim(),
      'studentName': studentName.trim(),
      'courseYear': courseYear.trim(),
      'email': email.trim(),
      'subject': subject,
      'reason': reason,
      'examTime': examTime,
      'additionalDetails': additionalDetails.trim(),
      'documentUrl': documentUrl,
      'status': 'pending',
      'createdAt': Timestamp.now(),
    });
  }
}
