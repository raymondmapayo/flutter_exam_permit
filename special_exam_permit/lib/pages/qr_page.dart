import 'package:flutter/material.dart';

import 'qr_display_page.dart';
import '../components/custom_button.dart';

class QRPage extends StatelessWidget {
  const QRPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ExamFlow'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.school, size: 100),

              const SizedBox(height: 20),
              const Text(
                'Special Examination Request',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text(
                'Generate the QR code for students '
                'to access the special examination request form.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              CustomButton(
                text: 'SHOW QR CODE',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QRDisplayPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
