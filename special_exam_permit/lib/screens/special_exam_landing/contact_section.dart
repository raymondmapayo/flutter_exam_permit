import 'package:flutter/material.dart';
import 'package:special_exam_permit/pages/request_form_page.dart';

import 'um_theme.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ready to file your request?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          const Text(
            'Requests are reviewed on a rolling basis, usually within 2 working days.',
            style: TextStyle(
              fontSize: 13.5,
              color: Color(0xFF5C4A4D),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: UMTheme.gold,
                foregroundColor: UMTheme.maroon,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/login-page');
              },
              child: const Text(
                'Request a special exam',
                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const _ScheduleCard(),
          const SizedBox(height: 28),
          const Center(
            child: Text(
              'University of Mindanao · Special Exam Permit System',
              style: TextStyle(fontSize: 11.5, color: Color(0xFFA08F8F)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: UMTheme.goldLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: UMTheme.maroon,
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text(
              "This term's key dates",
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 14),
          const _DateRow(label: 'Filing opens', value: 'Sept 15'),
          const _DateRow(label: 'Filing deadline', value: 'Oct 3'),
          const _DateRow(label: 'Approval released', value: 'Within 2 days'),
          const _DateRow(
            label: 'Exam window',
            value: 'Oct 6 – Oct 10',
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _DateRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isLast;

  const _DateRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: UMTheme.maroon.withOpacity(0.12),
            width: isLast ? 0 : 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Color(0xFF7A6A6D)),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
