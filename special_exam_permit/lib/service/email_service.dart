import 'dart:convert';

import 'package:http/http.dart' as http;

class EmailService {
  static const String scriptUrl =
      'https://script.google.com/macros/s/AKfycbwHnoXYSdFRCJXxj8nuH64ktsPjrC3DxfagkQ3UQV07t3jJxA5JZqt2Eg13YOdcVx-oVg/exec';

  static Future<void> sendExamStatusEmail({
    required String email,
    required String studentName,
    required String subject,
    required String examTime,
    required String status,
    String? examSlipUrl,
  }) async {
    final response = await http.post(
      Uri.parse(scriptUrl),
      body: {
        'email': email,
        'studentName': studentName,
        'subject': subject,
        'examTime': examTime,
        'status': status,
        'examSlipUrl': examSlipUrl ?? '',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to send email: '
        '${response.statusCode} ${response.body}',
      );
    }

    try {
      final result = jsonDecode(response.body);

      if (result['success'] != true) {
        throw Exception(result['message'] ?? 'Failed to send email.');
      }
    } catch (e) {
      throw Exception('Invalid response from Google Apps Script: $e');
    }
  }
}
