import 'package:flutter/material.dart';
import 'package:untitest/main.dart';
import 'package:untitest/first.dart';
import 'package:untitest/second.dart';

class AppRoutes {
  static const main = '/main';
  static const first = '/first';
  static const second = '/second';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) {
        switch (settings.name) {
          case AppRoutes.main:
            return const MyApp();
          case AppRoutes.first:
            return const First();
          case AppRoutes.second:
            return const Second();
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