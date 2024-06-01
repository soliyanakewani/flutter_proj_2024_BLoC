
import 'package:equatable/equatable.dart';

abstract class UserSettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangeNameRequested extends UserSettingsEvent {
  final String newName;

  ChangeNameRequested({required this.newName});

  @override
  List<Object?> get props => [newName];
}

class ChangePasswordRequested extends UserSettingsEvent {
  final String newPassword;

  ChangePasswordRequested({required this.newPassword});

  @override
  List<Object?> get props => [newPassword];
}