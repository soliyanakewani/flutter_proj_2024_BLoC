import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_event.dart';
import 'signup_state.dart';
import 'package:flutter_proj_2024/infrastructure/auth/sevices/auth_service.dart'; // Adjust the import path as necessary

class SignUpBloc extends Bloc<SignupEvent, SignUpState> {
  final AuthService authService;

  SignUpBloc({required this.authService}) : super(SignUpInitial());

  @override
  Stream<SignUpState> mapEventToState(SignupEvent event) async* {
    if (event is SignUpSubmitted) {
      yield SignUpLoading();
      try {
        // Call your AuthService to handle the signup logic
        await authService.signUp({
          'name': event.name,
          'email': event.email,
          'password': event.password,
          'role': event.isAdmin ? 'admin' : 'user',
        });

        yield SignUpSuccess();
      } catch (e) {
        yield SignUpFailure(errorMessage: e.toString());
      }
    }
  }
}
