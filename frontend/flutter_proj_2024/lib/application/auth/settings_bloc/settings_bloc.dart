


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj_2024/application/auth/settings_bloc/settings_event.dart';
import 'package:flutter_proj_2024/application/auth/settings_bloc/settings_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettingsBloc extends Bloc<UserSettingsEvent, UserSettingsState> {
  final String apiUrl;
  final FlutterSecureStorage secureStorage;

  UserSettingsBloc({
    required this.apiUrl,
    required this.secureStorage,
  }) : super(UserSettingsInitial()) {
    on<ChangeNameRequested>(_onChangeNameRequested);
    on<ChangePasswordRequested>(_onChangePasswordRequested);
  }

  Future<void> _onChangeNameRequested(ChangeNameRequested event, Emitter<UserSettingsState> emit) async {
    emit(UserSettingsLoading());
    try {
      final token = await secureStorage.read(key: 'token');
      if (token == null) {
        emit(UserSettingsFailure(error: "Token not found"));
        return;
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      if (userId == null) {
        emit(UserSettingsFailure(error: "User ID not found"));
        return;
      }

      final response = await http.put(
        Uri.parse('$apiUrl/users/$userId/name'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          'name': event.newName,
        }),
      );

      print('Change Name Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        // Update name in secure storage
        await secureStorage.write(key: 'name', value: event.newName);
        emit(UserSettingsSuccess(message: "Name changed successfully"));
      } else {
        emit(UserSettingsFailure(error: "Failed to change name"));
      }
    } catch (error) {
      emit(UserSettingsFailure(error: error.toString()));
    }
  }

  Future<void> _onChangePasswordRequested(ChangePasswordRequested event, Emitter<UserSettingsState> emit) async {
    emit(UserSettingsLoading());
    try {
      final token = await secureStorage.read(key: 'token');
      if (token == null) {
        emit(UserSettingsFailure(error: "Token not found"));
        return;
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      if (userId == null) {
        emit(UserSettingsFailure(error: "User ID not found"));
        return;
      }

      final response = await http.put(
        Uri.parse('$apiUrl/users/$userId/password'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          'password': event.newPassword,
        }),
      );

      print('Change Password Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        emit(UserSettingsSuccess(message: "Password changed successfully"));
      } else {
        emit(UserSettingsFailure(error: "Failed to change password"));
      }
    } catch (error) {
      emit(UserSettingsFailure(error: error.toString()));
    }
  }
}