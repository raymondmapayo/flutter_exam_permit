import 'package:flutter/material.dart';
import 'package:special_exam_permit/screens/special_exam_landing/um_theme.dart';
import 'package:special_exam_permit/model/user_model.dart';

class StudentHomePage extends StatelessWidget {
  final VoidCallback onRequestTap;
  final UserModel user;
  const StudentHomePage({
    super.key,
    required this.onRequestTap,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${user.studentName}! 👋',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: UMTheme.maroon,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'Request your special examination permit online.',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),

            const SizedBox(height: 25),

            // =========================
            // MAIN REQUEST CARD
            // =========================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                color: UMTheme.maroon,
                borderRadius: BorderRadius.circular(22),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 58,
                    height: 58,

                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),

                    child: const Icon(
                      Icons.assignment_outlined,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Special Examination Permit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Submit your request and supporting document '
                    'online without needing to immediately visit '
                    'the office.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(
                      onPressed: onRequestTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: UMTheme.gold,
                        foregroundColor: UMTheme.maroon,

                        padding: const EdgeInsets.symmetric(vertical: 14),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      child: const Text(
                        'Request Special Exam',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // =========================
            // QUICK OVERVIEW
            // =========================
            const Text(
              'Quick Overview',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: UMTheme.maroon,
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    icon: Icons.pending_actions,
                    title: 'Pending',
                    value: '0',
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _statCard(
                    icon: Icons.check_circle_outline,
                    title: 'Approved',
                    value: '0',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    icon: Icons.cancel_outlined,
                    title: 'Rejected',
                    value: '0',
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _statCard(
                    icon: Icons.description_outlined,
                    title: 'Total Requests',
                    value: '0',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // =========================
            // IMPORTANT INFORMATION
            // =========================
            const Text(
              'Important Information',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: UMTheme.maroon,
              ),
            ),

            const SizedBox(height: 14),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade200),
              ),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),

                    decoration: BoxDecoration(
                      color: UMTheme.maroon.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.info_outline,
                      color: UMTheme.maroon,
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Expanded(
                    child: Text(
                      'Make sure your supporting document is valid '
                      'before submitting your special examination request.',
                      style: TextStyle(fontSize: 14, height: 1.5),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // =========================
            // HOW IT WORKS
            // =========================
            const Text(
              'How It Works',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: UMTheme.maroon,
              ),
            ),

            const SizedBox(height: 14),

            _step(
              number: '1',
              title: 'Submit Request',
              description: 'Fill out the request form and upload your supporting document.',
            ),

            _step(
              number: '2',
              title: 'Admin Review',
              description: 'The administrator will review your information and document.',
            ),

            _step(
              number: '3',
              title: 'Receive Result',
              description:
                  'You will receive the result through the email you provided.',
            ),
          ],
        ),
      ),
    );
  }

  static Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: Colors.grey.shade200),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: UMTheme.maroon, size: 28),

          const SizedBox(height: 12),

          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: UMTheme.maroon,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  static Widget _step({
    required String number,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,

            alignment: Alignment.center,

            decoration: const BoxDecoration(
              color: UMTheme.maroon,
              shape: BoxShape.circle,
            ),

            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: UMTheme.maroon,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
