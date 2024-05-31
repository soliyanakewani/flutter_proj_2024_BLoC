import 'package:bloc/bloc.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_event.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_state.dart';
import 'package:flutter_proj_2024/domain/auth/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignUpRequested>(_onSignUpRequested);
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await authRepository.login(event.email, event.password);
      final token = result?['token'];
      emit(AuthSuccess(token: token));
    } catch (e) {
      print('Login error: $e'); // Log error
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  void _onSignUpRequested(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await authRepository.signup(event.name, event.email, event.password, event.isAdmin);
      final token = result?['token'];
      emit(AuthSuccess(token: token));
    } catch (e) {
      print('Signup error: $e'); // Log error
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }
}
