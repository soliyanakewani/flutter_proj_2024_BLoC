import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_event.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_state.dart';
import 'package:flutter_proj_2024/domain/auth/repositories/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final FlutterSecureStorage secureStorage;

  AuthBloc({required this.authRepository, required this.secureStorage}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<LoggedOut>(_onLoggedOut);
    on<AppStarted>(_onAppStarted);
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await authRepository.login(event.email, event.password);
      final token = result?['token'];
      final role = result?['role'];
      final name = result?['name'];
      if (token != null && role != null && name != null) {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        final userId = decodedToken['id'];

        await secureStorage.write(key: 'token', value: token);
        await secureStorage.write(key: 'role', value: role);
        await secureStorage.write(key: 'name', value: name);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', userId);

        emit(AuthSuccess(token: token, role: role, name: name));
      } else {
        emit(AuthFailure(errorMessage: 'Invalid login response'));
      }
    } catch (e) {
      print('Login error: $e');
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  void _onSignUpRequested(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await authRepository.signup(event.name, event.email, event.password, event.isAdmin);
      final token = result?['token'];
      final role = result?['role'];
      final name = result?['name'];
      if (token != null && role != null && name != null) {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        final userId = decodedToken['id'];

        await secureStorage.write(key: 'token', value: token);
        await secureStorage.write(key: 'role', value: role);
        await secureStorage.write(key: 'name', value: name);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', userId);

        emit(AuthSuccess(token: token, role: role, name: name));
      } else {
        emit(AuthFailure(errorMessage: 'Invalid signup response'));
      }
    } catch (e) {
      print('Signup error: $e');
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    try {
      await secureStorage.delete(key: 'token');
      await secureStorage.delete(key: 'role');
      await secureStorage.delete(key: 'name');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('userId');
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final token = await secureStorage.read(key: 'token');
    final role = await secureStorage.read(key: 'role');
    final name = await secureStorage.read(key: 'name');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    if (token != null && role != null && name != null && userId != null) {
      emit(AuthSuccess(token: token, role: role, name: name));
    } else {
      emit(AuthInitial());
    }
  }
}