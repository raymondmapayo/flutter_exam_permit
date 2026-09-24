import 'package:cloud_firestore/cloud_firestore.dart';

import 'email_service.dart';

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

  // ============================================================
  // DELETE EXAM REQUEST
  // ============================================================

  Future<void> deleteExamRequest(String documentId) async {
    await _firestore
        .collection('exams_students_resquest')
        .doc(documentId)
        .delete();
  }

  // ============================================================
  // UPDATE EXAM REQUEST
  // ============================================================

  Future<void> updateExamRequest(
    String documentId,
    Map<String, dynamic> data,
  ) async {
    await _firestore
        .collection('exams_students_resquest')
        .doc(documentId)
        .update(data);
  }

  // ============================================================
  // GET EXAM REQUESTS
  // ============================================================

  Stream<QuerySnapshot> getExamRequests() {
    return _firestore
        .collection('exams_students_resquest')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // ============================================================
  // UPDATE STATUS + SEND EMAIL
  // ============================================================

  Future<void> updateExamRequestStatus({
    required String documentId,
    required String status,
  }) async {
    final requestRef = _firestore
        .collection('exams_students_resquest')
        .doc(documentId);

    final requestDoc = await requestRef.get();

    if (!requestDoc.exists) {
      throw Exception('Exam request not found.');
    }

    final data = requestDoc.data();

    if (data == null) {
      throw Exception('Exam request data is empty.');
    }

    final normalizedStatus = status.trim().toLowerCase();

    if (normalizedStatus != 'approved' && normalizedStatus != 'rejected') {
      throw Exception('Invalid status. Only approved or rejected are allowed.');
    }

    // ============================================================
    // GET STUDENT DATA BEFORE UPDATE
    // ============================================================

    final email = data['email']?.toString() ?? '';

    final studentName = data['studentName']?.toString() ?? '';

    final subject = data['subject']?.toString() ?? '';

    final examTime = data['examTime']?.toString() ?? '';

    if (email.isEmpty) {
      throw Exception('Student email is missing.');
    }

    // ============================================================
    // UPDATE FIRESTORE
    // ============================================================

    await requestRef.update({
      'status': normalizedStatus,
      'updatedAt': Timestamp.now(),
    });

    // ============================================================
    // SEND EMAIL
    // ============================================================

    await EmailService.sendExamStatusEmail(
      email: email,
      studentName: studentName,
      subject: subject,
      examTime: examTime,
      status: normalizedStatus,
      examSlipUrl: null,
    );
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
