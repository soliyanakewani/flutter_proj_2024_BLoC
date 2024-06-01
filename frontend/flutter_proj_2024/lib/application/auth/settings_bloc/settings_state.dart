
import 'package:equatable/equatable.dart';

abstract class UserSettingsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserSettingsInitial extends UserSettingsState {}

class UserSettingsLoading extends UserSettingsState {}

class UserSettingsSuccess extends UserSettingsState {
  final String message;

  UserSettingsSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class UserSettingsFailure extends UserSettingsState {
  final String error;

  UserSettingsFailure({required this.error});

  @override
  List<Object?> get props => [error];
}