
import 'package:flutter_bloc/flutter_bloc.dart';

class UserEvent {}

class LoadUser extends UserEvent {}

class UserState {
  final String username;
  UserState(this.username);
}

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState('')) {
    on<LoadUser>((event, emit) {
      emit(UserState('Test User'));
    });
  }
}