import 'package:flutter/material.dart';

import '../screens/special_exam_landing/um_theme.dart';

class UploadDocumentCard extends StatelessWidget {
  const UploadDocumentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEFE2C8)),
      ),
      child: Column(
        children: [
          const Icon(Icons.upload_file, color: UMTheme.maroon, size: 45),
          const SizedBox(height: 10),
          const Text(
            'Upload your exam permit',
            style: TextStyle(
              color: UMTheme.maroon,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Upload a certificate or supporting document.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF7A6A6D), fontSize: 12),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: UMTheme.maroon,
              side: const BorderSide(color: UMTheme.maroon),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Choose File'),
          ),
        ],
      ),
    );
  }
}
