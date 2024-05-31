abstract class AuthRepository {
  Future<Map<String, String>> signUp(Map<String, String> signUpDto);
  Future<Map<String, dynamic>?> login(Map<String, String> loginDto);
  Future<bool> isAuthenticated(String? token);
  Future<Map<String, dynamic>> getCurrentUser(String token);
  Future<void> signOut();
  Future<String?> getToken();
}
