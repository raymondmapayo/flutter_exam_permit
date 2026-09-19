import 'package:flutter/material.dart';
import 'package:special_exam_permit/components/reason_card.dart';
import 'package:special_exam_permit/model/reason_model.dart';

import 'um_theme.dart';

class EligibilitySection extends StatelessWidget {
  const EligibilitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UMTheme.background,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Who can request one?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 8),

          const Text(
            'Check that your situation matches one of the accepted reasons below.',
            style: TextStyle(fontSize: 13, color: Color(0xFF5C4A4D)),
          ),

          const SizedBox(height: 20),

          ...List.generate(reasonList.length, (index) {
            final reason = reasonList[index];

            return ReasonCard(
              index: index + 1,
              title: reason.title,
              description: reason.description,
            );
          }),
        ],
      ),
    );
  }
}
