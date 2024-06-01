

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj_2024/application/auth/settings_bloc/settings_bloc.dart';
import 'package:flutter_proj_2024/application/auth/settings_bloc/settings_event.dart';
import 'package:flutter_proj_2024/application/auth/settings_bloc/settings_state.dart';
import 'package:flutter_proj_2024/shared/widgets/appbar.dart';
import 'package:flutter_proj_2024/shared/widgets/drawer.dart';
import 'package:flutter_proj_2024/shared/widgets/text_field_widget.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _saveChanges(BuildContext context) {
    final newName = _nameController.text;
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (newPassword.isNotEmpty && newPassword != confirmPassword) {
      _showSnackBar("Passwords do not match!");
      return;
    }

    if (newName.isNotEmpty) {
      context.read<UserSettingsBloc>().add(ChangeNameRequested(newName: newName));
    }

    if (newPassword.isNotEmpty) {
      context.read<UserSettingsBloc>().add(ChangePasswordRequested(newPassword: newPassword));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(),
      drawer: AppDrawer(),
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Change your Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const Text(
                'Name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFieldWidget(
                obscure: false,
                controller: _nameController,
                hintText: 'Enter new name',
              ),
              const SizedBox(height: 16),
              const Text(
                'Password',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFieldWidget(
                hintText: 'Enter new password',
                obscure: true,
                controller: _newPasswordController,
              ),
              const SizedBox(height: 16),
              const Text(
                'Confirm Password',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFieldWidget(
                hintText: 'Confirm new password',
                obscure: true,
                controller: _confirmPasswordController,
              ),
              const SizedBox(height: 30),
              BlocConsumer<UserSettingsBloc, UserSettingsState>(
                listener: (context, state) {
                  if (state is UserSettingsSuccess) {
                    _showSnackBar(state.message);
                  } else if (state is UserSettingsFailure) {
                    _showSnackBar(state.error);
                  }
                },
                builder: (context, state) {
                  return Center(
                    child: ElevatedButton(
                      onPressed: state is UserSettingsLoading
                          ? null
                          : () => _saveChanges(context),
                      child: state is UserSettingsLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Save changes',
                              style: TextStyle(fontSize: 20),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}