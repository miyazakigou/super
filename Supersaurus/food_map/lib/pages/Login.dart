import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    try {
      await AuthService.signInWithEmail(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("ログインに失敗しました: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EFD4),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Icon(Icons.restaurant_menu, size: 80, color: Colors.brown),
              const SizedBox(height: 10),
              const Text("飯屋GO!!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              const Text("login", style: TextStyle(fontSize: 26)),
              const SizedBox(height: 30),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "メールアドレス"),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "パスワード"),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {},
                child: const Text("パスワードを忘れた方"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text("ログイン"),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignupPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text("新規登録"),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),
              _socialButton("Googleで続行", Icons.g_mobiledata, AuthService.signInWithGoogle),
              const SizedBox(height: 10),
              _socialButton("Appleで続行", Icons.apple),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton(String text, IconData icon, [VoidCallback? onPressed]) {
  return ElevatedButton.icon(
    onPressed: onPressed,
    icon: Icon(icon, color: Colors.black),
    label: Text(text, style: const TextStyle(color: Colors.black)),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 48),
    ),
  );
}

}
