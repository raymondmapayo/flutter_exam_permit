import 'package:flutter/material.dart';
import 'package:special_exam_permit/screens/special_exam_landing/um_theme.dart';

import '../widgets/stat_card.dart';
import '../widgets/request_table_row.dart';
import '../dialogs/request_details_dialog.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: UMTheme.maroon,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Manage special examination requests.',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 24),

          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final cardWidth = width > 700 ? (width - 32) / 3 : width;

              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  StatCard(
                    width: cardWidth,
                    title: 'Pending',
                    value: '12',
                    icon: Icons.pending_actions,
                  ),
                  StatCard(
                    width: cardWidth,
                    title: 'Approved',
                    value: '25',
                    icon: Icons.check_circle_outline,
                  ),
                  StatCard(
                    width: cardWidth,
                    title: 'Rejected',
                    value: '5',
                    icon: Icons.cancel_outlined,
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 32),

          const Text(
            'Recent Requests',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 14),

          Card(
            elevation: 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Student')),
                  DataColumn(label: Text('Subject')),
                  DataColumn(label: Text('Exam Time')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Action')),
                ],
                rows: [
                  RequestTableRow.build(
                    context: context,
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
                  RequestTableRow.build(
                    context: context,
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
                  RequestTableRow.build(
                    context: context,
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
            ),
          ),
        ],
      ),
    );
  }
}
