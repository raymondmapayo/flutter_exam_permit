import 'package:cloud_firestore/cloud_firestore.dart';

class CrudExamInfoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getSubjects() {
    return _firestore
        .collection('exam_subjects')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  //EXAM SUBJECT
  Future<void> addSubject(String subjectName) async {
    final name = subjectName.trim();

    if (name.isEmpty) {
      throw Exception('Subject name cannot be empty.');
    }

    await _firestore.collection('exam_subjects').add({
      'name': name,
      'createdAt': Timestamp.now(),
    });
  }

  //UPDATE SUBJECT
  Future<void> updateSubject(String id, String subjectName) async {
    final name = subjectName.trim();

    if (name.isEmpty) {
      throw Exception('Subject name cannot be empty.');
    }

    await _firestore.collection('exam_subjects').doc(id).update({
      'name': name,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // DELETE SUBJECT
  Future<void> deleteSubject(String id) async {
    await _firestore.collection('exam_subjects').doc(id).delete();
  }

  // EXAM REASONS
  Stream<QuerySnapshot> getReasons() {
    return _firestore
        .collection('exam_reasons')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  //ADD REASONS
  Future<void> addReason(String reason) async {
    final name = reason.trim();

    if (name.isEmpty) {
      throw Exception('Reason cannot be empty.');
    }

    await _firestore.collection('exam_reasons').add({
      'name': name,
      'createdAt': Timestamp.now(),
    });
  }

  //UPDATE REASONS
  Future<void> updateReason(String id, String reason) async {
    final name = reason.trim();

    if (name.isEmpty) {
      throw Exception('Reason cannot be empty.');
    }

    await _firestore.collection('exam_reasons').doc(id).update({
      'name': name,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  //DELETE REASONS
  Future<void> deleteReason(String id) async {
    await _firestore.collection('exam_reasons').doc(id).delete();
  }

  // EXAM TIMES

  Stream<QuerySnapshot> getExamTimes() {
    return _firestore
        .collection('exam_times')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  //ADD TIME

  Future<void> addExamTime({
    required DateTime examDate,
    required String startTime,
    required String endTime,
  }) async {
    if (startTime.trim().isEmpty || endTime.trim().isEmpty) {
      throw Exception('Exam time cannot be empty.');
    }

    await _firestore.collection('exam_times').add({
      'examDate': Timestamp.fromDate(examDate),
      'startTime': startTime.trim(),
      'endTime': endTime.trim(),
      'createdAt': Timestamp.now(),
    });
  }

  // UPDATE TIME

  Future<void> updateExamTime({
    required String id,
    required DateTime examDate,
    required String startTime,
    required String endTime,
  }) async {
    if (startTime.trim().isEmpty || endTime.trim().isEmpty) {
      throw Exception('Exam time cannot be empty.');
    }

    await _firestore.collection('exam_times').doc(id).update({
      'examDate': Timestamp.fromDate(examDate),
      'startTime': startTime.trim(),
      'endTime': endTime.trim(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteExamTime(String id) async {
    await _firestore.collection('exam_times').doc(id).delete();
  }
}
