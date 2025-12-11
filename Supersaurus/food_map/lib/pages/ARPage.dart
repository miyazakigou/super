import 'package:flutter/material.dart';

class ARPage extends StatelessWidget {
  const ARPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ARビュー"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.view_in_ar,
              size: 100,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            const Text(
              "AR機能は現在準備中です",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            const Text(
              "実際のカメラ表示やAR実装を\nここに追加できます",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // 戻るボタン
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("戻る"),
            ),
          ],
        ),
      ),
    );
  }
}
