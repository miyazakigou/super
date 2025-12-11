import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_map/pages/Password_Reset.dart';
import 'package:food_map/pages/Delete_Account.dart';




class AccountSettingScreen extends StatelessWidget {
  const AccountSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE5C6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          _buildAvatarSection(),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildMenuItem(context, 'ユーザー名', 'kagureon'),
                _divider(),
                _buildMenuItem(context, 'メールアドレス', 'kagureon@1234.com'),
                _divider(),
                _buildMenuItem(context, '登録ID', 'kcsf5959'),
                _divider(),
                _buildMenuItem(context, '性別', '男'),
              ],
            ),
          ),
          //ログアウトボタンだけ反応するぞ！
          const SizedBox(height: 30),
          _buildActionButton(
            text: 'パスワード変更',
            color: Colors.blue,
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PasswordResetScreen()),
              );
            },
          ),
          _buildActionButton(
            text: 'ログアウト',
            color: Colors.black,
            onTap: () async {
            await FirebaseAuth.instance.signOut();
            if (context.mounted) {
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            }
          },
          ),
          _buildActionButton(
            text: 'アカウント削除',
            color: Colors.red,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DeleteAccountPage()),
              );
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildAvatarSection() {
    //アイコンはまだないぞ！
    return Column(
      children: const [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/splash/IMG_7918.png'),
        ),
        SizedBox(height: 8),
        Text('写真またはアバター編集'),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(title),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.left,
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      height: 1,
      color: Colors.black26,
      margin: const EdgeInsets.only(left: 16),
    );
  }

  Widget _buildActionButton({required String text, required Color color, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}