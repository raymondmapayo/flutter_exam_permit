import 'package:flutter/material.dart';
import 'package:special_exam_permit/components/step_row.dart';
import 'package:special_exam_permit/model/step_model.dart';

import 'um_theme.dart';

class StepsSection extends StatelessWidget {
  const StepsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UMTheme.maroon,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'How to apply',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 20),

          ...List.generate(stepList.length, (index) {
            final step = stepList[index];

            return StepRow(
              number: index + 1,
              title: step.title,
              description: step.description,
              isLast: index == stepList.length - 1,
            );
          }),
        ],
      ),
    );
  }
}
