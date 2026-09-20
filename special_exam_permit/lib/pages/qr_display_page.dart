// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:special_exam_permit/pages/request_form_page.dart';

// class QRDisplayPage extends StatelessWidget {
//   const QRDisplayPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Student Request QR Code'),
//         centerTitle: true,
//       ),

//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24),

//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'Scan this QR Code',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),

//               const SizedBox(height: 30),

//               QrImageView(
//                 data: 'ExamFlow Special Exam Request',
//                 version: QrVersions.auto,
//                 size: 300,
//                 backgroundColor: Colors.white,
//               ),

//               const SizedBox(height: 30),

//               const Text(
//                 'Students can scan this QR code '
//                 'to submit their special examination request.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16),
//               ),

//               const SizedBox(height: 25),

//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const ExamRequestPage(),
//                       ),
//                     );
//                   },
//                   child: const Text(
//                     'OPEN REQUEST FORM',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
