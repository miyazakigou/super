import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pages/home.dart';
import 'pages/Login.dart';
import 'pages/splash.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashPage();
        }
        //ログイン済み
        if (snapshot.hasData) {
          return const HomePage();
        }
        //未ログイン
        return const LoginPage();
      },
    );
  }
}
