import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wall_e/login/bloc/login_bloc.dart';
import 'package:wall_e/login/login_page_parent.dart';
import 'di/di.dart' as di;
import 'utils/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.setupDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<LoginBloc>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginPageParent(),
        routes: [
          GoRoute(
            path: 'home',
            builder: (context, state) => const LoginPageParent(),
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(
      builder: (context) {
        return MaterialApp.router(
          title: 'wall-e',
          routerConfig: router,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
