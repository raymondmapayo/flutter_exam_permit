import 'package:flutter/material.dart';
import 'package:special_exam_permit/screens/special_exam_landing/um_theme.dart';

class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 20),

            // =========================
            // PROFILE ICON
            // =========================
            Container(
              width: 95,
              height: 95,

              decoration: BoxDecoration(
                color: UMTheme.maroon.withOpacity(0.1),
                shape: BoxShape.circle,
              ),

              child: const Icon(Icons.person, color: UMTheme.maroon, size: 55),
            ),

            const SizedBox(height: 15),

            const Text(
              'Student Profile',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: UMTheme.maroon,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              'Your student information',
              style: TextStyle(color: Colors.grey.shade600),
            ),

            const SizedBox(height: 30),

            _profileItem(
              icon: Icons.badge_outlined,
              title: 'Student ID',
              value: 'Not set',
            ),

            _profileItem(
              icon: Icons.person_outline,
              title: 'Student Name',
              value: 'Not set',
            ),

            _profileItem(
              icon: Icons.school_outlined,
              title: 'Course & Year',
              value: 'Not set',
            ),

            _profileItem(
              icon: Icons.email_outlined,
              title: 'Email',
              value: 'Not set',
            ),
          ],
        ),
      ),
    );
  }

  static Widget _profileItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,

      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),

      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: UMTheme.maroon.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),

            child: Icon(icon, color: UMTheme.maroon),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
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
