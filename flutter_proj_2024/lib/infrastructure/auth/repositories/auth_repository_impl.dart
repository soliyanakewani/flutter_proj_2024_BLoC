import 'package:flutter_proj_2024/domain/auth/repositories/auth_repository.dart';
import 'package:flutter_proj_2024/infrastructure/auth/sevices/auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;

  AuthRepositoryImpl(this.authService);

  @override
  Future<Map<String, String>> signUp(Map<String, String> signUpDto) {
    return authService.signUp(signUpDto);
  }

  @override
  Future<Map<String, dynamic>?> login(Map<String, String> loginDto) {
    return authService.login(loginDto);
  }

  @override
  Future<bool> isAuthenticated(String? token) {
    return authService.isAuthenticated(token);
  }

  @override
  Future<Map<String, dynamic>> getCurrentUser(String token) {
    return authService.getCurrentUser(token);
  }

  @override
  Future<void> signOut() {
    return authService.signOut();
  }

  @override
  Future<String?> getToken() {
    return authService.getToken();
  }
}
