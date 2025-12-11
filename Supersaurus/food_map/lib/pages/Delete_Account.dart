import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Delete_Account_Complete.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  bool _isDeleting = false;

  Future<void> _deleteAccount() async {
    setState(() {
      _isDeleting = true;
    });

    try {
      await FirebaseAuth.instance.currentUser?.delete();
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DeleteAccountCompletePage()),
        );
      }
    } catch (e) {
      setState(() {
        _isDeleting = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("アカウント削除に失敗しました: $e")),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EFD4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: const Icon(Icons.restaurant_menu, size: 80, color: Colors.brown), //ロゴのアイコンを探すor既存のアイコンを編集(トリミング)して使う
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 170),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.delete_forever, size: 72, color: Colors.redAccent),
                      const SizedBox(height: 16),
                      const Text('アカウントを削除しますか？', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      const Text('アカウントを削除すると全てのデータが失われます。戻すことはできません。', textAlign: TextAlign.center),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                            onPressed: () => Navigator.pop(context),
                            child: const Text('キャンセル'),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                            onPressed: _isDeleting ? null : _deleteAccount,
                            child: _isDeleting
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : const Text('削除する'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}