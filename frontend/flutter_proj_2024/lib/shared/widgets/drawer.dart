import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_bloc.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_event.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_state.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String userName = 'Loading...';
        String userEmail = '';
        String userRole = '';

        if (state is AuthSuccess) {
          userName = state.name;
          userRole = state.role;
          // Fetch user details based on token if necessary
        }

        return Drawer(
          backgroundColor: const Color.fromARGB(255, 252, 241, 230),
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(),
                accountName: Text(
                  userName,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(
                  userEmail,
                  style: const TextStyle(color: Colors.black),
                ),
                currentAccountPicture: const CircleAvatar(child: Icon(Icons.person)),
              ),
              // Customer-specific items
              if (userRole == 'customer') ...[
                ListTile(
                  onTap: () {
                    context.go('/home_page');
                  },
                  leading: const Icon(Icons.home),
                  title: const Text('HOME'),
                ),
                ListTile(
                  onTap: () {
                    context.go('/booking_page');
                  },
                  leading: const Icon(Icons.book_online),
                  title: const Text('BOOK'),
                ),
                ListTile(
                  onTap: () {
                    context.go('/status_page');
                  },
                  leading: const Icon(Icons.label),
                  title: const Text('Status'),
                ),
              ],
              // Shared items for both admin and customer
              ListTile(
                onTap: () {
                  context.go('/settings_page');
                },
                leading: const Icon(Icons.settings),
                title: const Text('SETTINGS'),
              ),
              ListTile(
                onTap: () {
                  context.go('/feedback_page');
                },
                leading: const Icon(Icons.feedback),
                title: const Text('FEEDBACK'),
              ),
              // Admin-specific items
              if (userRole == 'admin') ...[
                ListTile(
                  onTap: () {
                    context.go('/admin_page');
                  },
                  leading: const Icon(Icons.admin_panel_settings),
                  title: const Text('EDIT'),
                ),
              ],
              // Shared logout item for both roles
              ListTile(
                onTap: () async {
                  
                  context.read<AuthBloc>().add(LoggedOut());
                  context.go('/login');
                },
                leading: const Icon(Icons.logout),
                title: const Text('LOGOUT'),
              ),
            ],
          ),
        );
      },
    );
  }
}