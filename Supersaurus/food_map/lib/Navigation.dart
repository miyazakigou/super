import 'package:flutter/material.dart';
import 'package:food_map/main.dart';
import 'package:food_map/Login.dart';
import 'package:food_map/splash.dart';

class AppRoutes {
  static const main = '/main';
  static const login = '/login';
  static const splash = '/splash';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) {
        switch (settings.name) {
          case AppRoutes.main:
            return const MyApp();
          case AppRoutes.login:
            return const ();
          case AppRoutes.splash:
            return const ();
          default:
            return const Scaffold(
              body: Center(
                child: Text('No route defined for this path'),
              ),
            );
        }
      },
    );
  }
}