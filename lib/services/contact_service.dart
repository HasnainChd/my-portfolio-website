import 'dart:convert';
import 'package:http/http.dart' as http;

class ContactService {
  static const String _serviceId = 'service_yt8enkh';
  static const String _templateId = 'template_gslqbcn';
  static const String _publicKey = 'kO_pRnE4NpMvuY6td';
  static const String _emailJsUrl = 'https://api.emailjs.com/api/v1.0/email/send';

  static Future<void> sendEmail({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_emailJsUrl),
        headers: {
          'Content-Type': 'application/json',
          'origin': 'http://localhost:3000',
        },
        body: json.encode({
          'service_id': _serviceId,
          'template_id': _templateId,
          'user_id': _publicKey,
          'template_params': {
            'name': name,
            'email': email,
            'message': message,
          },
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to send email: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error sending email: $e');
    }
  }
}
