import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

class SignUpSubmitted extends SignupEvent {
  final String name;
  final String email;
  final String password;
  final bool isAdmin;

  const SignUpSubmitted({
    required this.name,
    required this.email,
    required this.password,
    required this.isAdmin,
  });

  @override
  List<Object?> get props => [name, email, password, isAdmin];
}
