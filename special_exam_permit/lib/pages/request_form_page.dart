import 'package:flutter/material.dart';
import 'package:special_exam_permit/main_request_form.dart';

class ExamRequestPage extends StatefulWidget {
  const ExamRequestPage({super.key});

  @override
  State<ExamRequestPage> createState() => _ExamRequestPageState();
}

class _ExamRequestPageState extends State<ExamRequestPage> {
  // DROPDOWN VALUES
  String? selectedSubject;
  String? selectedReason;
  String? selectedExamTime;

  // TEXTFIELD VALUES
  String studentId = '';
  String studentName = '';
  String courseYear = '';
  String email = '';
  String additionalDetails = '';

  // ERROR MESSAGES
  String? studentIdError;
  String? studentNameError;
  String? courseYearError;
  String? emailError;
  String? subjectError;
  String? reasonError;
  String? additionalDetailsError;
  String? examTimeError;

  // SUBMIT REQUEST
  void _submitRequest() {
    setState(() {
      // STUDENT ID
      studentIdError = studentId.trim().isEmpty
          ? 'Student ID is required'
          : null;

      // STUDENT NAME
      studentNameError = studentName.trim().isEmpty
          ? 'Student Name is required'
          : null;

      // COURSE & YEAR
      courseYearError = courseYear.trim().isEmpty
          ? 'Course & Year is required'
          : null;

      // EMAIL
      emailError = email.trim().isEmpty ? 'Email is required' : null;

      // SUBJECT
      subjectError = selectedSubject == null ? 'Please select a subject' : null;

      // REASON
      reasonError = selectedReason == null ? 'Please select a reason' : null;

      // ADDITIONAL DETAILS
      additionalDetailsError = additionalDetails.trim().isEmpty
          ? 'Additional details are required'
          : null;

      // EXAM TIME
      examTimeError = selectedExamTime == null
          ? 'Please select an exam time'
          : null;
    });

    // CHECK IF THERE IS ANY ERROR
    final hasError =
        studentIdError != null ||
        studentNameError != null ||
        courseYearError != null ||
        emailError != null ||
        subjectError != null ||
        reasonError != null ||
        additionalDetailsError != null ||
        examTimeError != null;

    // STOP IF THERE IS AN ERROR
    if (hasError) {
      return;
    }

    // SUCCESS
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Request submitted successfully.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainRequestForm(
      // DROPDOWN VALUES
      selectedSubject: selectedSubject,
      selectedReason: selectedReason,
      selectedExamTime: selectedExamTime,

      // ERROR MESSAGES
      studentIdError: studentIdError,
      studentNameError: studentNameError,
      courseYearError: courseYearError,
      emailError: emailError,
      subjectError: subjectError,
      reasonError: reasonError,
      additionalDetailsError: additionalDetailsError,
      examTimeError: examTimeError,

      // SUBJECT
      onSubjectChanged: (value) {
        setState(() {
          selectedSubject = value;
          subjectError = null;
        });
      },

      // REASON
      onReasonChanged: (value) {
        setState(() {
          selectedReason = value;
          reasonError = null;
        });
      },

      // EXAM TIME
      onExamTimeChanged: (value) {
        setState(() {
          selectedExamTime = value;
          examTimeError = null;
        });
      },

      // STUDENT ID
      onStudentIdChanged: (value) {
        setState(() {
          studentId = value;

          if (value.trim().isNotEmpty) {
            studentIdError = null;
          }
        });
      },

      // STUDENT NAME
      onStudentNameChanged: (value) {
        setState(() {
          studentName = value;

          if (value.trim().isNotEmpty) {
            studentNameError = null;
          }
        });
      },

      // COURSE & YEAR
      onCourseYearChanged: (value) {
        setState(() {
          courseYear = value;

          if (value.trim().isNotEmpty) {
            courseYearError = null;
          }
        });
      },

      // EMAIL
      onEmailChanged: (value) {
        setState(() {
          email = value;

          if (value.trim().isNotEmpty) {
            emailError = null;
          }
        });
      },

      // ADDITIONAL DETAILS
      onAdditionalDetailsChanged: (value) {
        setState(() {
          additionalDetails = value;

          if (value.trim().isNotEmpty) {
            additionalDetailsError = null;
          }
        });
      },

      // SUBMIT
      onSubmit: _submitRequest,
    );
  }
}
