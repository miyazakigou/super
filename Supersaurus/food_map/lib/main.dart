import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'auth_gate.dart';
//自宅のローカルの構成にしちゃったから学校でパスの変更しなきゃいけない↓
import 'package:food_map/pages/Settings.dart';
import 'package:food_map/pages/Login.dart';
import 'package:food_map/pages/signup.dart';
import 'package:food_map/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
      routes: {
    '/login': (context) =>  LoginPage(),
    '/signup': (context) =>  SignupPage(),
    '/home': (context) =>  HomePage(),
    '/settings': (context) => const AccountSettingScreen(),},
    );
  }
}
