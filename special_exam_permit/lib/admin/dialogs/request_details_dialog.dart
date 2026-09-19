import 'package:flutter/material.dart';

class RequestDetailsDialog {
  static void show(
    BuildContext context,
    String student,
    String subject,
    String examTime,
    String status,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Exam Request'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Student: $student'),
              const SizedBox(height: 8),
              Text('Subject: $subject'),
              const SizedBox(height: 8),
              Text('Exam Time: $examTime'),
              const SizedBox(height: 8),
              Text('Status: $status'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
