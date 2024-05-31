abstract class AuthEvent {}

class SignUpEvent extends AuthEvent {
  final Map<String, String> signUpDto;
  SignUpEvent(this.signUpDto);
}

class LoginEvent extends AuthEvent {
  final Map<String, String> loginDto;
  LoginEvent(this.loginDto);
}

class CheckAuthEvent extends AuthEvent {
  final String? token;
  CheckAuthEvent(this.token);
}

class LogoutEvent extends AuthEvent {}
