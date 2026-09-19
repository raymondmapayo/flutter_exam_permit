import 'package:flutter/material.dart';

import '../widgets/request_card.dart';
import '../dialogs/request_details_dialog.dart';

import 'package:special_exam_permit/screens/special_exam_landing/um_theme.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Requests',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: UMTheme.maroon,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Review and process student exam requests.',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 24),

          RequestCard(
            student: 'Raymond Mapayo',
            subject: 'Mathematics',
            examTime: '9:00 AM',
            status: 'Pending',
            onView: () {
              RequestDetailsDialog.show(
                context,
                'Raymond Mapayo',
                'Mathematics',
                '9:00 AM',
                'Pending',
              );
            },
          ),

          RequestCard(
            student: 'Juan Dela Cruz',
            subject: 'Programming',
            examTime: '1:00 PM',
            status: 'Approved',
            onView: () {
              RequestDetailsDialog.show(
                context,
                'Juan Dela Cruz',
                'Programming',
                '1:00 PM',
                'Approved',
              );
            },
          ),

          RequestCard(
            student: 'Maria Santos',
            subject: 'Database',
            examTime: '3:00 PM',
            status: 'Pending',
            onView: () {
              RequestDetailsDialog.show(
                context,
                'Maria Santos',
                'Database',
                '3:00 PM',
                'Pending',
              );
            },
          ),
        ],
      ),
    );
  }
}
