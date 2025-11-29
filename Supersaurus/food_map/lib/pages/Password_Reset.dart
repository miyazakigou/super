import 'package:flutter/material.dart';
import 'package:food_map/pages/Help.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE5C6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              // とりあえずLogin.dartと一緒にしたsignupやsplashは別のアイコンを使用しているので合わせた方がいい！
              const Icon(Icons.restaurant_menu, size: 80, color: Colors.brown), //ロゴのアイコンを探すor既存のアイコンを編集(トリミング)して使う
              const SizedBox(height: 10),
              const Text("飯飯GO!!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              
              const SizedBox(height: 20),

              // タイトル
              const Text(
                "パスワードリセット",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // アイコン
              const Icon(Icons.error_outline, size: 60, color: Colors.brown),

              const SizedBox(height: 20),

              // 説明テキスト
              const Text(
                "パスワードをリセットするには、\nメールアドレスを入力してください。\n"
                "入力されたメールアドレスが正しい場合、\n認証コードが送信されます。",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 30),

              // メール入力欄
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "メールアドレス",
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // ボタン
              //俺、配色センスないから誰かセンスがいいやつ変えてて
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B2C24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    print("送信: ${_emailController.text}");
                  },
                  child: const Text("リンクを送信", style: TextStyle(fontSize: 18)),
                ),
              ),

              const SizedBox(height: 30),

              // ヘルプリンク
              Column(
                children: [
                  const Text("リンクが届かない場合"),
                  TextButton(
                    onPressed: () {
                     Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => const HelpPage()),
                     );
                    },
                    child: const Text("ヘルプ画面へ"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
