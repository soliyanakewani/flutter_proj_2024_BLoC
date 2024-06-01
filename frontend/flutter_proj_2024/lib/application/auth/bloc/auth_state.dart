import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String token;
  final String role;
  final String name;

  AuthSuccess({required this.token, required this.role, required this.name});

  @override
  List<Object> get props => [token, role, name];
}

class AuthFailure extends AuthState {
  final String errorMessage;

  AuthFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
