import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api';

  // Login - call backend
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/login'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email, 'password': password}),
          )
          .timeout(
            Duration(seconds: 10),
            onTimeout: () => throw Exception('Request timeout'),
          );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'token': data['data']['token'],
          'user': data['data']['user'],
        };
      } else {
        final data = jsonDecode(response.body);
        return {'success': false, 'error': data['message'] ?? 'Login gagal'};
      }
    } catch (e) {
      return {'success': false, 'error': 'Koneksi error: $e'};
    }
  }

  // Get customers (untuk nanti)
  static Future<Map<String, dynamic>> getCustomers(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/customers'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'success': false, 'error': 'Gagal mengambil data'};
      }
    } catch (e) {
      return {'success': false, 'error': 'Koneksi error: $e'};
    }
  }
}
