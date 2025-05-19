import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileRepository {
  final String baseUrl = 'http://20.19.80.46/api/v1';

  Future<Map<String, dynamic>?> getProfile(String accessToken) async {
    final url = Uri.parse('$baseUrl/me');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'];
    }
    return null;
  }

  Future<bool> updateProfile({
    required String accessToken,
    required String name,
    required String gender,
    required String phone,
    required String address,
  }) async {
    final url = Uri.parse('$baseUrl/me');
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        "name": name,
        "gender": gender,
        "phone": phone,
        "address": address,
      }),
    );
    return response.statusCode == 200;
  }
}
