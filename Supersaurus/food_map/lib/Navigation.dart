import 'package:flutter/material.dart';
import 'pages/home.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomePage(),
    );
  }
}
