import 'package:flutter/material.dart';

import '../screens/special_exam_landing/um_theme.dart';

class UploadDocumentCard extends StatelessWidget {
  final VoidCallback onChooseFile;
  final String? fileName;

  const UploadDocumentCard({
    super.key,
    required this.onChooseFile,
    this.fileName,
  });

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
            onPressed: onChooseFile,
            style: OutlinedButton.styleFrom(
              foregroundColor: UMTheme.maroon,
              side: const BorderSide(color: UMTheme.maroon),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(fileName ?? 'Choose File'),
          ),

          if (fileName != null) ...[
            const SizedBox(height: 8),
            Text(
              fileName!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black87, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }
}
