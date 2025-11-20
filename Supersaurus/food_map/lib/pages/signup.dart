import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _usernameController = TextEditingController();
  String _passwordErrorMessage = "";
  String _usernameErrorMessage = "";
  bool _isLoading = false;

  Future<void> _handleSignup() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _passwordConfirmController.text.trim();
    final username = _usernameController.text.trim();

    // エラーメッセージをリセット
    setState(() {
      _passwordErrorMessage = "";
      _usernameErrorMessage = "";
    });

    // バリデーション
    bool hasError = false;

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("メールアドレスを入力してください")),
      );
      return;
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("パスワードを入力してください")),
      );
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _passwordErrorMessage = "※パスワードが一致しません";
      });
      hasError = true;
    }

    if (username.isEmpty) {
      setState(() {
        _usernameErrorMessage = "ユーザー名を入力してください";
      });
      hasError = true;
    }

    if (hasError) {
      return;
    }

    // 送信処理
    setState(() {
      _isLoading = true;
    });

    try {
      await AuthService.signUpWithEmail(email, password);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("登録に成功しました")),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("登録に失敗しました: $e")),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EFD4),
      body: SafeArea(
        child: Column(
          children: [
            // ヘッダー部分
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Image.asset(
                      'assets/splash/logonew.png',
                      height: 160,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            // コンテンツ
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6B4423),
                        ),
                      ),
                      const SizedBox(height: 40),
                      // メールアドレス
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "メールアドレス",
                          hintStyle: const TextStyle(color: Color(0xFFBBBBBB)),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF6B4423),
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF6B4423),
                              width: 1,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // パスワード
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "パスワード",
                          hintStyle: const TextStyle(color: Color(0xFFBBBBBB)),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF6B4423),
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF6B4423),
                              width: 1,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // パスワード確認
                      TextField(
                        controller: _passwordConfirmController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "パスワード（確認）",
                          hintStyle: const TextStyle(color: Color(0xFFBBBBBB)),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF6B4423),
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF6B4423),
                              width: 1,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // パスワードエラーメッセージ
                      if (_passwordErrorMessage.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _passwordErrorMessage,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      
                      // ユーザー名入力
                      const SizedBox(height: 40),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: "ユーザー名",
                          hintStyle: const TextStyle(color: Color(0xFFBBBBBB)),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF6B4423),
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF6B4423),
                              width: 1,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // ユーザー名エラーメッセージ
                      if (_usernameErrorMessage.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _usernameErrorMessage,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      const SizedBox(height: 8),
                      // ログイン画面へのリンク
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "既に登録済みの方は",
                            style: TextStyle(
                              color: Color(0xFF6B4423),
                              fontSize: 12,
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                            ),
                            child: const Text(
                              "こちら",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      // 送信ボタン
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleSignup,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6B4423),
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: const Color(0xFF9B8B7B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : const Text(
                                  "送信",
                                  style: TextStyle(fontSize: 16),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
