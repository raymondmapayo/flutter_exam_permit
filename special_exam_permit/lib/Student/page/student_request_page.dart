// import 'package:flutter/material.dart';
// import 'package:special_exam_permit/screens/special_exam_landing/um_theme.dart';

// class StudentRequestPage extends StatelessWidget {
//   final VoidCallback? onStartRequest;

//   const StudentRequestPage({super.key, this.onStartRequest});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 10),

//             const Text(
//               'Special Examination Request',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: UMTheme.maroon,
//               ),
//             ),

//             const SizedBox(height: 6),

//             Text(
//               'Complete the form to submit your request.',
//               style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
//             ),

//             const SizedBox(height: 25),

//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(18),
//                 border: Border.all(color: Colors.grey.shade200),
//               ),
//               child: Column(
//                 children: [
//                   const Icon(
//                     Icons.assignment_outlined,
//                     color: UMTheme.maroon,
//                     size: 55,
//                   ),

//                   const SizedBox(height: 15),

//                   const Text(
//                     'Request a Special Examination',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: UMTheme.maroon,
//                     ),
//                   ),

//                   const SizedBox(height: 8),

//                   Text(
//                     'Fill out the required information and '
//                     'upload your supporting document.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Colors.grey.shade600,
//                       height: 1.4,
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: onStartRequest,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: UMTheme.maroon,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text(
//                         'Start Request',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
