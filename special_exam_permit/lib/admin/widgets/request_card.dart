import 'package:flutter/material.dart';
import 'package:special_exam_permit/screens/special_exam_landing/um_theme.dart';

class RequestCard extends StatelessWidget {
  final String student;
  final String subject;
  final String examTime;
  final String status;
  final VoidCallback onView;

  const RequestCard({
    super.key,
    required this.student,
    required this.subject,
    required this.examTime,
    required this.status,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    final bool isApproved = status == 'Approved';

    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: UMTheme.goldLight.withOpacity(0.25),
                  child: const Icon(
                    Icons.person_outline,
                    color: UMTheme.maroon,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    student,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: isApproved
                        ? Colors.green.withOpacity(0.12)
                        : Colors.orange.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: isApproved
                          ? Colors.green.shade700
                          : Colors.orange.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              'Subject: $subject',
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 5),
            Text(
              'Exam Time: $examTime',
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onView,
                icon: const Icon(Icons.visibility_outlined),
                label: const Text('View Request'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
