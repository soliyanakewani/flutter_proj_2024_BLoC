import 'package:flutter_proj_2024/domain/auth/repositories/auth_repository.dart';

class Login {
  final AuthRepository repository;

  Login(this.repository);

  Future<Map<String, dynamic>?> call(Map<String, String> loginDto) {
    return repository.login(loginDto);
  }
}
