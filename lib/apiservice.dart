import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = "http://10.0.2.2:8000";

  /// User Signup API
  Future<Map<String, dynamic>> createUser(Map<String, dynamic> userData) async {
    final url = Uri.parse("$_baseUrl/users/");
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body); // Return parsed response
      } else {
        // Handle error responses
        final error = jsonDecode(response.body);
        throw Exception("Error: ${error['message'] ?? 'Unknown error'}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
