import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_bloc.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_event.dart';
import 'package:go_router/go_router.dart';


class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Oasis Hotel',
        style: TextStyle(
          color: Color.fromARGB(255, 95, 65, 65),
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            context.go('/login');
            context.read<AuthBloc>().add(LoggedOut());
            
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}