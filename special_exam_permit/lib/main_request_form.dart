import 'package:flutter/material.dart';
import 'package:special_exam_permit/model/exam_reason_model.dart';
import 'package:special_exam_permit/model/exam_subject_model.dart';
import 'package:special_exam_permit/model/exam_time_model.dart';
import 'package:special_exam_permit/screens/special_exam_landing/um_theme.dart';

import 'components/custom_dropdown.dart';
import 'components/form_label.dart';
import 'components/form_text_field.dart';
import 'components/upload_document_card.dart';

class MainRequestForm extends StatelessWidget {
  // DROPDOWN VALUES
  final String? selectedSubject;
  final String? selectedReason;
  final String? selectedExamTime;

  // DROPDOWN CALLBACKS
  final ValueChanged<String?> onSubjectChanged;
  final ValueChanged<String?> onReasonChanged;
  final ValueChanged<String?> onExamTimeChanged;

  // TEXTFIELD CALLBACKS
  final ValueChanged<String> onStudentIdChanged;
  final ValueChanged<String> onStudentNameChanged;
  final ValueChanged<String> onCourseYearChanged;
  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onAdditionalDetailsChanged;

  // SUBMIT
  final VoidCallback onSubmit;

  // ERROR MESSAGES
  final String? studentIdError;
  final String? studentNameError;
  final String? courseYearError;
  final String? emailError;
  final String? subjectError;
  final String? reasonError;
  final String? additionalDetailsError;
  final String? examTimeError;

  const MainRequestForm({
    super.key,

    // DROPDOWN VALUES
    required this.selectedSubject,
    required this.selectedReason,
    required this.selectedExamTime,

    // DROPDOWN CALLBACKS
    required this.onSubjectChanged,
    required this.onReasonChanged,
    required this.onExamTimeChanged,

    // TEXTFIELD CALLBACKS
    required this.onStudentIdChanged,
    required this.onStudentNameChanged,
    required this.onCourseYearChanged,
    required this.onEmailChanged,
    required this.onAdditionalDetailsChanged,

    // SUBMIT
    required this.onSubmit,

    // ERROR MESSAGES
    this.studentIdError,
    this.studentNameError,
    this.courseYearError,
    this.emailError,
    this.subjectError,
    this.reasonError,
    this.additionalDetailsError,
    this.examTimeError,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UMTheme.background,

      // APP BAR
      appBar: AppBar(
        backgroundColor: UMTheme.maroon,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'ExamFlow',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PAGE TITLE
              const Text(
                'Special Examination Request',
                style: TextStyle(
                  color: UMTheme.maroon,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Fill out the form below to request a special examination permit.',
                style: TextStyle(color: Color(0xFF7A6A6D), fontSize: 14),
              ),

              const SizedBox(height: 25),

              // STUDENT INFORMATION
              const Text(
                'Student Information',
                style: TextStyle(
                  color: UMTheme.maroon,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              // STUDENT ID
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Student ID'),
                  errorText: studentIdError,
                ),
              ),

              const SizedBox(height: 18),

              // STUDENT NAME
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Student Name'),

                  errorText: studentNameError,
                ),
              ),
              const SizedBox(height: 18),

              // COURSE & YEAR
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('COURSE & YEAR'),
                  errorText: courseYearError,
                ),
              ),

              const SizedBox(height: 18),

              // EMAIL
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Email'),
                  errorText: emailError,
                ),
              ),

              const SizedBox(height: 28),

              // EXAM INFORMATION
              const Text(
                'Exam Information',
                style: TextStyle(
                  color: UMTheme.maroon,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              // SUBJECT
              const FormLabel(text: 'Subject'),

              CustomDropdown(
                hint: 'Select Subject',
                options: examSubjectList
                    .map((subject) => subject.name)
                    .toList(),
                value: selectedSubject,
                onChanged: onSubjectChanged,
                errorText: subjectError,
              ),

              const SizedBox(height: 18),

              // REASON
              const FormLabel(text: 'Reason for Special Exam'),

              CustomDropdown(
                hint: 'Select Reason',
                options: examReasonList.map((reason) => reason.name).toList(),
                value: selectedReason,
                onChanged: onReasonChanged,
                errorText: reasonError,
              ),

              const SizedBox(height: 18),

              // ADDITIONAL DETAILS
              const FormLabel(text: 'Additional Details'),

              FormTextField(
                hint: 'Explain your reason or provide additional details',
                maxLines: 4,
                onChanged: onAdditionalDetailsChanged,
                errorText: additionalDetailsError,
              ),

              const SizedBox(height: 20),

              // DOCUMENT UPLOAD
              const FormLabel(text: 'Supporting Document'),

              const UploadDocumentCard(),

              const SizedBox(height: 20),

              // EXAM TIME
              const FormLabel(text: 'Preferred Exam Time'),

              CustomDropdown(
                hint: 'Select Exam Time',
                options: examTimeList.map((time) => time.time).toList(),
                value: selectedExamTime,
                onChanged: onExamTimeChanged,
                errorText: examTimeError,
              ),

              const SizedBox(height: 30),

              // SUBMIT BUTTON
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: UMTheme.maroon,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'SUBMIT REQUEST',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
