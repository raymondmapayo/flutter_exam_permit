import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:special_exam_permit/model/user_model.dart';
import 'package:special_exam_permit/screens/special_exam_landing/um_theme.dart';

class StudentRequestsPage extends StatelessWidget {
  final UserModel user;

  const StudentRequestsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('exams_students_resquest')
            .where('studentId', isEqualTo: user.studentId)
            .snapshots(),

        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: UMTheme.maroon),
            );
          }

          // Error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to load requests.\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          final requests = snapshot.data?.docs ?? [];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                const Text(
                  'My Requests',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: UMTheme.maroon,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'View your submitted special examination requests.',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),

                const SizedBox(height: 25),

                // WALAY REQUEST
                if (requests.isEmpty)
                  _buildEmptyState()
                // NAAY REQUEST
                else
                  ...requests.map((doc) => _buildRequestCard(doc)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(
            Icons.description_outlined,
            size: 55,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 15),

          const Text(
            'No Requests Yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: UMTheme.maroon,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Your submitted requests will appear here.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    final subject = data['subject'] ?? '';
    final reason = data['reason'] ?? '';
    final examTime = data['examTime'] ?? '';
    final status = data['status'] ?? 'pending';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.description_outlined,
                color: UMTheme.maroon,
                size: 28,
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  subject,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: UMTheme.maroon,
                  ),
                ),
              ),

              _buildStatus(status),
            ],
          ),

          const SizedBox(height: 15),

          _buildInfoRow(Icons.info_outline, 'Reason', reason),

          const SizedBox(height: 8),

          _buildInfoRow(Icons.access_time, 'Exam Time', examTime),

          const SizedBox(height: 8),

          _buildInfoRow(
            Icons.person_outline,
            'Student',
            data['studentName'] ?? '',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 19, color: Colors.grey.shade600),

        const SizedBox(width: 8),

        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatus(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _statusBackground(status),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: _statusColor(status),
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green.shade700;

      case 'rejected':
        return Colors.red.shade700;

      case 'invalid':
        return Colors.orange.shade700;

      default:
        return UMTheme.maroon;
    }
  }

  Color _statusBackground(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green.shade50;

      case 'rejected':
        return Colors.red.shade50;

      case 'invalid':
        return Colors.orange.shade50;

      default:
        return Colors.grey.shade100;
    }
  }
}
