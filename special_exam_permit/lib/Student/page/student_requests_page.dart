import 'package:flutter/material.dart';
import 'package:special_exam_permit/screens/special_exam_landing/um_theme.dart';

class StudentRequestsPage extends StatelessWidget {
  const StudentRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
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

            Container(
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
            ),
          ],
        ),
      ),
    );
  }
}
