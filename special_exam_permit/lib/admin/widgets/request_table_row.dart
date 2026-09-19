import 'package:flutter/material.dart';

class RequestTableRow {
  static DataRow build({
    required BuildContext context,
    required String student,
    required String subject,
    required String examTime,
    required String status,
    required VoidCallback onView,
  }) {
    return DataRow(
      cells: [
        DataCell(Text(student)),
        DataCell(Text(subject)),
        DataCell(Text(examTime)),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: status == 'Approved'
                  ? Colors.green.withOpacity(0.12)
                  : Colors.orange.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: status == 'Approved'
                    ? Colors.green.shade700
                    : Colors.orange.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        DataCell(TextButton(onPressed: onView, child: const Text('View'))),
      ],
    );
  }
}
