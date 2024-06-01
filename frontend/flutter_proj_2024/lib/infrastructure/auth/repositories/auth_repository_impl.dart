import 'package:flutter_proj_2024/domain/auth/repositories/auth_repository.dart';
import 'package:flutter_proj_2024/infrastructure/auth/data_sources/auth_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi authApi;

  AuthRepositoryImpl({required this.authApi});

  @override
  Future<Map<String, dynamic>?> login(String email, String password) async {
    final response = await authApi.login(email, password);
    if (response != null) {
      final token = response['token'];
      final role = response['role'];
      final name = response['name'];
      if (token != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('role', role);
        await prefs.setString('name', name);
      }
    }
    return response;
  }

  @override
  Future<Map<String, dynamic>?> signup(String name, String email, String password, bool isAdmin) async {
    final response = await authApi.signup(name, email, password, isAdmin);
    if (response != null) {
      final token = response['token'];
      final role = response['role'];
      final name = response['name'];
      if (token != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('role', role);
        await prefs.setString('name', name);
      }
    }
    return response;
  }

  @override
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('role');
    await prefs.remove('name');
    await authApi.logout();
  }
}