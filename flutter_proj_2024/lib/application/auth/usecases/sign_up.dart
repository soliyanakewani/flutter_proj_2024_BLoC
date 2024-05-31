import 'package:flutter_proj_2024/domain/auth/repositories/auth_repository.dart';

class SignUp {
  final AuthRepository repository;

  SignUp(this.repository);

  Future<Map<String, String>> call(Map<String, String> signUpDto) {
    return repository.signUp(signUpDto);
  }
}
