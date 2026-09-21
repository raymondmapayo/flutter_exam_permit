import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/request_card.dart';
import '../dialogs/request_details_dialog.dart';

import 'package:special_exam_permit/screens/special_exam_landing/um_theme.dart';
import 'package:special_exam_permit/service/crud_exam_info_service.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CrudExamInfoService service = CrudExamInfoService();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Requests',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: UMTheme.maroon,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Review and process student exam requests.',
            style: TextStyle(color: Colors.grey.shade600),
          ),

          const SizedBox(height: 24),

          // =====================================================
          // FETCH REQUESTS FROM FIRESTORE
          // =====================================================
          StreamBuilder<QuerySnapshot>(
            stream: service.getExamRequests(),
            builder: (context, snapshot) {
              // =================================================
              // LOADING
              // =================================================

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: CircularProgressIndicator(color: UMTheme.maroon),
                  ),
                );
              }

              // =================================================
              // ERROR
              // =================================================

              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Error loading requests: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }

              // =================================================
              // NO REQUESTS
              // =================================================

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Text(
                      'No exam requests found.',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ),
                );
              }

              // =================================================
              // REQUEST DATA
              // =================================================

              final requests = snapshot.data!.docs;

              return Column(
                children: requests.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;

                  final studentName =
                      data['studentName']?.toString() ?? 'Unknown';

                  final subject = data['subject']?.toString() ?? '-';

                  final examTime = data['examTime']?.toString() ?? '-';

                  // =================================================
                  // NORMALIZE FIREBASE STATUS
                  // =================================================

                  final status =
                      data['status']?.toString().toLowerCase() ?? 'pending';

                  // =================================================
                  // REQUEST CARD
                  // =================================================

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: RequestCard(
                      student: studentName,
                      subject: subject,
                      examTime: examTime,

                      // Firebase status
                      status: status,

                      // =================================================
                      // VIEW REQUEST
                      // =================================================
                      onView: () {
                        RequestDetailsDialog.show(
                          context,
                          studentName,
                          subject,
                          examTime,
                          status,
                        );
                      },
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
