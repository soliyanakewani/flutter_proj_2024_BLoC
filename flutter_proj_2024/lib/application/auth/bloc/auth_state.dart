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

  AuthSuccess({required this.token, required this.role});

  @override
  List<Object> get props => [token, role];
}

class AuthFailure extends AuthState {
  final String errorMessage;

  AuthFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
