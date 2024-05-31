import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthApi {
  final String baseUrl;

  AuthApi({required this.baseUrl});

  Future<Map<String, dynamic>?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Map<String, dynamic>?> signup(String name, String email, String password, bool isAdmin) async {
    print('Signup request: $name, $email, $password, $isAdmin'); // Log request data
    final response = await http.post(
      Uri.parse('$baseUrl/auth/signup'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'email': email,
        'password': password,
        'role': isAdmin ? 'admin' : 'customer'
      }),
    );

    print('Signup response status: ${response.statusCode}'); // Log response status
    print('Signup response body: ${response.body}'); // Log response body

    if (response.statusCode == 201) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to sign up: ${response.statusCode} - ${response.body}');
    }
  }
}
