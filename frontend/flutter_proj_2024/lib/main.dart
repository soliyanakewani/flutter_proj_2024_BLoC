
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj_2024/application/booking/bloc/home_bloc.dart';
import 'package:flutter_proj_2024/application/booking/bloc/user_bloc.dart';
import 'package:flutter_proj_2024/application/feedback/bloc/feedback_bloc.dart';
import 'package:flutter_proj_2024/domain/room/room_repository.dart';
import 'package:flutter_proj_2024/presentation/booking/pages/home_page.dart';
import 'package:flutter_proj_2024/presentation/feedback/pages/feedback_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_bloc.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_event.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_state.dart';
import 'package:flutter_proj_2024/application/auth/settings_bloc/settings_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_proj_2024/application/admin/bloc/admin_bloc.dart';
import 'package:flutter_proj_2024/application/booking/bloc/booking_bloc.dart';
import 'package:flutter_proj_2024/infrastructure/admin/repositories/admin_repository_impl.dart';
import 'package:flutter_proj_2024/infrastructure/auth/data_sources/auth_api.dart';
import 'package:flutter_proj_2024/infrastructure/auth/repositories/auth_repository_impl.dart';
import 'package:flutter_proj_2024/infrastructure/booking/data_sources/booking_remote_data_source.dart';
import 'package:flutter_proj_2024/infrastructure/booking/repositories/booking_repository_impl.dart';
import 'package:flutter_proj_2024/infrastructure/feedback/data_sources/feedback_remote_data_source.dart';
import 'package:flutter_proj_2024/infrastructure/feedback/repositories/feedback_repository_impl.dart';
import 'package:flutter_proj_2024/presentation/admin/pages/admin_page.dart';
import 'package:flutter_proj_2024/presentation/auth/pages/log_in_page.dart';
import 'package:flutter_proj_2024/presentation/auth/pages/sign_up_page.dart';
import 'package:flutter_proj_2024/presentation/auth/pages/settings_page.dart';
import 'package:flutter_proj_2024/presentation/booking/pages/booking_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authApi = AuthApi(baseUrl: 'http://localhost:3000');
  final authRepository = AuthRepositoryImpl(authApi: authApi);
  final adminRepository = AdminRepositoryImpl(RoomRepository());
  final secureStorage = FlutterSecureStorage();
  final prefs = await SharedPreferences.getInstance();
  final String userId = prefs.getString('userId') ?? '';
  final String apiUrl = 'http://localhost:3000';
  final feedbackRemoteDataSource = FeedbackRemoteDataSource(apiUrl);
  final feedbackRepository = FeedbackRepositoryImpl(feedbackRemoteDataSource);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FeedbackRepositoryImpl>(
          create: (context) => feedbackRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AdminBloc>(
            create: (context) => AdminBloc(adminRepository),
          ),
          BlocProvider<BookingBloc>(
            create: (context) => BookingBloc(
              bookingRepository: BookingRepositoryImpl(BookingRemoteDataSource()),
            ),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: authRepository,
              secureStorage: secureStorage,
            )..add(AppStarted()),
          ),
          BlocProvider<UserSettingsBloc>(
            create: (context) => UserSettingsBloc(
              apiUrl: apiUrl,
              secureStorage: secureStorage,
            ),
          ),
          BlocProvider<FeedbackBloc>(
            create: (context) => FeedbackBloc(
              RepositoryProvider.of<FeedbackRepositoryImpl>(context),
            ),
          ),
          BlocProvider(create: (_) => ImageBloc()..add(LoadImages())),
          BlocProvider(create: (_) => UserBloc()..add(LoadUser())),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => SignUpPage(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          path: '/booking_page',
          builder: (context, state) => BookingPage(),
        ),
        GoRoute(
          path: '/settings_page',
          builder: (context, state) => SettingsPage(),
        ),
        GoRoute(
          path: '/admin_page',
          builder: (context, state) => AdminPage(),
        ),
        GoRoute(
          path: '/feedback_page',
          builder: (context, state) => FeedbackPage(),
        ),
        GoRoute(
          path: '/home_page',
          builder: (context, state) => HomePage(),
        ),
      ],
      // redirect: (context, state) {
      //   final authBloc = BlocProvider.of<AuthBloc>(context);
      //   final authState = authBloc.state;

      //   if (authState is AuthInitial) {
      //     return '/login';
      //   } else if (authState is AuthSuccess) {
      //     final location = state.uri.toString();
      //     if (location == '/login' || location == '/') {
      //       return authState.role == 'admin' ? '/admin_page' : '/booking_page';
      //     }
      //   }
      //   return null;
      // },
      refreshListenable: StreamListenable(
        BlocProvider.of<AuthBloc>(context).stream,
      ),
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}

class StreamListenable extends ChangeNotifier {
  final Stream _stream;

  StreamListenable(Stream stream) : _stream = stream {
    _stream.listen((_) {
      notifyListeners();
    });
  }
}