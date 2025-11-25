import 'package:flutter/material.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  Widget build(BuildContext context) {
    backgroundColor: const Color(0xFFF8EFD4);
    body: Center(
      children: [
        const Text("利用規約画面", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        const Text(
          "ここに利用規約の詳細な内容が表示されます。ユーザーはこの内容をよく読み、同意した上でサービスを利用してください。",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        const 
      ]
    )
  }
}