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
    final client = http.Client();

    try {
      // ============================================================
      // CREATE POST REQUEST
      // ============================================================

      final request = http.Request('POST', Uri.parse(scriptUrl));

      request.headers['Content-Type'] = 'application/x-www-form-urlencoded';

      request.bodyFields = {
        'email': email,
        'studentName': studentName,
        'subject': subject,
        'examTime': examTime,
        'status': status,
        'examSlipUrl': examSlipUrl ?? '',
      };

      // ============================================================
      // SEND REQUEST
      // ============================================================

      final streamedResponse = await client.send(request);

      print('==============================================');
      print('             EMAIL DEBUG');
      print('==============================================');
      print('STATUS CODE: ${streamedResponse.statusCode}');
      print('HEADERS: ${streamedResponse.headers}');

      // ============================================================
      // HANDLE GOOGLE APPS SCRIPT REDIRECT
      // ============================================================

      if (streamedResponse.statusCode == 302 ||
          streamedResponse.statusCode == 301 ||
          streamedResponse.statusCode == 303 ||
          streamedResponse.statusCode == 307 ||
          streamedResponse.statusCode == 308) {
        final redirectUrl = streamedResponse.headers['location'];

        print('REDIRECT URL: $redirectUrl');

        if (redirectUrl == null || redirectUrl.isEmpty) {
          throw Exception(
            'Google Apps Script returned ${streamedResponse.statusCode} '
            'but no redirect URL was provided.',
          );
        }

        // ============================================================
        // FOLLOW REDIRECT
        // ============================================================

        final redirectResponse = await client.get(Uri.parse(redirectUrl));

        final body = redirectResponse.body;

        print('REDIRECT STATUS: ${redirectResponse.statusCode}');
        print('REDIRECT BODY: $body');
        print('==============================================');

        if (redirectResponse.statusCode != 200) {
          throw Exception(
            'Google Apps Script redirect failed: '
            '${redirectResponse.statusCode}',
          );
        }

        // ============================================================
        // DECODE JSON RESPONSE
        // ============================================================

        dynamic result;

        try {
          result = jsonDecode(body);
        } catch (e) {
          throw Exception(
            'Invalid JSON response from Google Apps Script: $body',
          );
        }

        if (result is! Map) {
          throw Exception('Unexpected response from Google Apps Script.');
        }

        if (result['success'] != true) {
          throw Exception(
            result['message']?.toString() ??
                'Google Apps Script failed to send the email.',
          );
        }

        print('EMAIL SENT SUCCESSFULLY');
        return;
      }

      // ============================================================
      // NORMAL 200 RESPONSE
      // ============================================================

      final body = await streamedResponse.stream.bytesToString();

      print('BODY: $body');
      print('==============================================');

      if (streamedResponse.statusCode != 200) {
        throw Exception(
          'Failed to send email: '
          '${streamedResponse.statusCode} $body',
        );
      }

      // ============================================================
      // DECODE JSON
      // ============================================================

      dynamic result;

      try {
        result = jsonDecode(body);
      } catch (e) {
        throw Exception('Invalid JSON response from Google Apps Script: $body');
      }

      if (result is! Map) {
        throw Exception('Unexpected response from Google Apps Script.');
      }

      if (result['success'] != true) {
        throw Exception(
          result['message']?.toString() ??
              'Google Apps Script failed to send the email.',
        );
      }

      print('EMAIL SENT SUCCESSFULLY');
    } catch (e) {
      print('==============================================');
      print('EMAIL ERROR');
      print(e);
      print('==============================================');

      throw Exception('Failed to send email: $e');
    } finally {
      client.close();
    }
  }
}
