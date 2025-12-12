import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_map/pages/Password_Reset.dart';
import 'package:food_map/pages/Delete_Account.dart';
import 'package:food_map/pages/Logout.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';




class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({Key? key}) : super(key: key);

  @override
  _AccountSettingScreenState createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  String _userName = 'kagureon';
  String _email = 'kagureon@1234.com';
  String _userId = 'kcsf5959';
  String _gender = '男';
  String? _avatarImagePath;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? 'kagureon';
      _email = prefs.getString('email') ?? 'kagureon@1234.com';
      _userId = prefs.getString('userId') ?? 'kcsf5959';
      _gender = prefs.getString('gender') ?? '男';
      _avatarImagePath = prefs.getString('avatarImagePath');
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _userName);
    await prefs.setString('email', _email);
    await prefs.setString('userId', _userId);
    await prefs.setString('gender', _gender);
    if (_avatarImagePath != null) {
      await prefs.setString('avatarImagePath', _avatarImagePath!);
    }
  }

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
                _buildMenuItem(context, 'ユーザー名', _userName),
                _divider(),
                _buildMenuItem(context, 'メールアドレス', _email),
                _divider(),
                _buildMenuItem(context, '登録ID', _userId),
                _divider(),
                _buildMenuItem(context, '性別', _gender),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LogoutPage()),
                );
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
    //初期アバターを表示
    return InkWell(
      onTap: _pickImage,
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: _avatarImagePath != null ? FileImage(File(_avatarImagePath!)) : null,
            backgroundColor: _avatarImagePath == null ? const Color(0xFFE0E0E0) : null,
            child: _avatarImagePath == null ? const Icon(Icons.person, size: 60, color: Colors.grey) : null,
          ),
          const SizedBox(height: 8),
          const Text('写真またはアバター編集'),
        ],
      ),
    );
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _avatarImagePath = pickedFile.path;
      });
      _saveSettings();
    }
  }

  Widget _buildMenuItem(BuildContext context, String title, String value) {
    return InkWell(
      onTap: () {
        _showEditDialog(context, title, value);
      },
      child: Container(
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

  void _showEditDialog(BuildContext context, String title, String currentValue) {
    if (title == '性別') {
      String selectedGender = currentValue;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, dialogSetState) {
              return AlertDialog(
                title: Text('$title の編集'),
                content: DropdownButton<String>(
                  value: selectedGender,
                  items: const [
                    DropdownMenuItem(value: '男', child: Text('男')),
                    DropdownMenuItem(value: '女', child: Text('女')),
                  ],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      dialogSetState(() {
                        selectedGender = newValue;
                      });
                    }
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('キャンセル'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _gender = selectedGender;
                      });
                      _saveSettings();
                      Navigator.of(context).pop();
                    },
                    child: const Text('保存'),
                  ),
                ],
              );
            },
          );
        },
      );
    } else {
      TextEditingController controller = TextEditingController(text: currentValue);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('$title の編集'),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: '$title を入力',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('キャンセル'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    if (title == 'ユーザー名') {
                      _userName = controller.text;
                    } else if (title == 'メールアドレス') {
                      _email = controller.text;
                    } else if (title == '登録ID') {
                      _userId = controller.text;
                    }
                  });
                  _saveSettings();
                  Navigator.of(context).pop();
                },
                child: const Text('保存'),
              ),
            ],
          );
        },
      );
    }
  }
}