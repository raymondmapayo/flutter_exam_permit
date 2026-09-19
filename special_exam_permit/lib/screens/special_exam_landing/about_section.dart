import 'package:flutter/material.dart';

import 'um_theme.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What is a special exam permit?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          const Text(
            "It's official clearance that lets a student take an exam outside "
            "the regular schedule — for reasons like illness, a schedule "
            "conflict, or an official school activity.",
            style: TextStyle(
              fontSize: 13.5,
              height: 1.6,
              color: Color(0xFF5C4A4D),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: UMTheme.goldLight,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                const Icon(Icons.laptop_mac, size: 56, color: UMTheme.maroon),
                const SizedBox(height: 12),
                Text(
                  'One request. Two approvals. Zero paperwork.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: UMTheme.maroonLight, fontSize: 13.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
