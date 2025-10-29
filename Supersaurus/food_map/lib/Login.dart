// ログイン画面の例
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('ログインする'),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            // ログインに成功したと仮定してトークンを保存
            await prefs.setString('access_token', 'example_token_123');

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
    );
  }
}

// メイン画面の例
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ホーム画面'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('ログアウト'),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.remove('access_token');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ),
      ),
    );
  }
}