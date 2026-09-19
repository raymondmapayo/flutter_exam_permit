import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:special_exam_permit/screens/special_exam_landing/um_theme.dart';
import 'package:special_exam_permit/service/exam_info_service.dart';

import '../widgets/exam_info_card.dart';
import '../widgets/exam_option.dart';
import '../dialogs/subject_dialogs.dart';
import '../dialogs/reason_dialogs.dart';
import '../dialogs/exam_time_dialogs.dart';
import '../helpers/date_helper.dart';

class ExamInformationPage extends StatelessWidget {
  final CrudExamInfoService examInfoService;

  const ExamInformationPage({super.key, required this.examInfoService});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Exam Information',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: UMTheme.maroon,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Manage the options available in the student request form.',
            style: TextStyle(color: Colors.grey.shade600),
          ),

          const SizedBox(height: 24),

          // SUBJECTS
          ExamInfoCard(
            icon: Icons.menu_book_outlined,
            title: 'Exam Subjects',
            onAdd: () {
              SubjectDialogs.showAdd(context, examInfoService);
            },
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: examInfoService.getSubjects(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: CircularProgressIndicator(color: UMTheme.maroon),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'Error loading subjects: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'No exam subjects added yet.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  return Column(
                    children: snapshot.data!.docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;

                      final subject = data['name']?.toString() ?? '';

                      return ExamOption(
                        text: subject,
                        onEdit: () {
                          SubjectDialogs.showEdit(
                            context,
                            examInfoService,
                            doc.id,
                            subject,
                          );
                        },
                        onDelete: () {
                          SubjectDialogs.delete(
                            context,
                            examInfoService,
                            doc.id,
                            subject,
                          );
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 18),

          // REASONS
          ExamInfoCard(
            icon: Icons.assignment_outlined,
            title: 'Exam Reasons',
            onAdd: () {
              ReasonDialogs.showAdd(context, examInfoService);
            },
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: examInfoService.getReasons(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: CircularProgressIndicator(color: UMTheme.maroon),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'Error loading reasons: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'No exam reasons added yet.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  return Column(
                    children: snapshot.data!.docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;

                      final reason = data['name']?.toString() ?? '';

                      return ExamOption(
                        text: reason,
                        onEdit: () {
                          ReasonDialogs.showEdit(
                            context,
                            examInfoService,
                            doc.id,
                            reason,
                          );
                        },
                        onDelete: () {
                          ReasonDialogs.delete(
                            context,
                            examInfoService,
                            doc.id,
                            reason,
                          );
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 18),

          // EXAM SCHEDULES
          ExamInfoCard(
            icon: Icons.access_time_outlined,
            title: 'Exam Schedules',
            onAdd: () {
              ExamTimeDialogs.showAdd(context, examInfoService);
            },
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: examInfoService.getExamTimes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: CircularProgressIndicator(color: UMTheme.maroon),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'Error loading exam schedules: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'No exam schedules added yet.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  return Column(
                    children: snapshot.data!.docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;

                      final Timestamp? examDate =
                          data['examDate'] as Timestamp?;

                      final startTime = data['startTime']?.toString() ?? '';

                      final endTime = data['endTime']?.toString() ?? '';

                      String scheduleText = '$startTime - $endTime';

                      if (examDate != null) {
                        scheduleText =
                            '${DateHelper.format(examDate.toDate())} • '
                            '$startTime - $endTime';
                      }

                      return ExamOption(
                        text: scheduleText,
                        onEdit: () {
                          ExamTimeDialogs.showEdit(
                            context,
                            examInfoService,
                            doc.id,
                            examDate?.toDate(),
                            startTime,
                            endTime,
                          );
                        },
                        onDelete: () {
                          ExamTimeDialogs.delete(
                            context,
                            examInfoService,
                            doc.id,
                            scheduleText,
                          );
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
