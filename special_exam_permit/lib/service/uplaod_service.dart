import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UploadFileService {
  Future<String> uploadFile(PlatformFile file) async {
    final cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'];
    final uploadPreset = dotenv.env['CLOUDINARY_UPLOAD_PRESET'];

    if (cloudName == null || cloudName.isEmpty) {
      throw Exception('CLOUDINARY_CLOUD_NAME is missing.');
    }

    if (uploadPreset == null || uploadPreset.isEmpty) {
      throw Exception('CLOUDINARY_UPLOAD_PRESET is missing.');
    }

    final Uint8List bytes = await file.readAsBytes();

    if (bytes.isEmpty) {
      throw Exception('Selected file is empty.');
    }

    final uri = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );

    final request = http.MultipartRequest('POST', uri);

    request.fields['upload_preset'] = uploadPreset;

    request.files.add(
      http.MultipartFile.fromBytes('file', bytes, filename: file.name),
    );

    final streamedResponse = await request.send();

    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      String message = 'Cloudinary upload failed.';

      try {
        final data = jsonDecode(response.body);

        message = data['error']?['message']?.toString() ?? message;
      } catch (_) {
        if (response.body.isNotEmpty) {
          message = response.body;
        }
      }

      throw Exception(message);
    }

    final data = jsonDecode(response.body);

    final secureUrl = data['secure_url']?.toString();

    if (secureUrl == null || secureUrl.isEmpty) {
      throw Exception('Cloudinary did not return a secure URL.');
    }

    return secureUrl;
  }
}
