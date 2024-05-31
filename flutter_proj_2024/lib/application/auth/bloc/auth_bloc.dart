import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:flutter_proj_2024/domain/auth/repositories/auth_repository.dart';
import 'package:flutter_proj_2024/application/auth/usecases/log_in.dart';
import 'package:flutter_proj_2024/application/auth/usecases/sign_up.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is SignUpEvent) {
      yield AuthLoading();
      try {
        final signUp = SignUp(authRepository);
        final token = await signUp(event.signUpDto);
        yield AuthAuthenticated(token: token['token']!);
      } catch (e) {
        yield AuthError(message: e.toString());
      }
    } else if (event is LoginEvent) {
      yield AuthLoading();
      try {
        final login = Login(authRepository);
        final response = await login(event.loginDto);
        if (response != null) {
          yield AuthAuthenticated(token: response['token']);
        } else {
          yield AuthError(message: 'Invalid email or password');
        }
      } catch (e) {
        yield AuthError(message: e.toString());
      }
    } else if (event is CheckAuthEvent) {
      yield AuthLoading();
      try {
        final isAuthenticated = await authRepository.isAuthenticated(event.token);
        if (isAuthenticated) {
          yield AuthAuthenticated(token: event.token!);
        } else {
          yield AuthUnauthenticated();
        }
      } catch (e) {
        yield AuthError(message: e.toString());
      }
    } else if (event is LogoutEvent) {
      await authRepository.signOut();
      yield AuthUnauthenticated();
    }
  }
}
