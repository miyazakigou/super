import 'package:flutter/material.dart';
import 'package:food_map/pages/ContactFormScreen.dart';
class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFCB), // ベージュ背景
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ① 閉じるボタン
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: IconButton(
                icon: const Icon(Icons.close, size: 32),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            // ② タイトル
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "FAQ(よくあるお問い合わせ)",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ③ 検索バー
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "検索",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ④ 問い合わせ内容カード
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFF8B4A32), width: 1.5),
                ),
                child: const Center(
                  child: Text(
                    "問い合わせ内容",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ⑤ お問い合わせフォームボタン
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactFormScreen()),
                  );

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B4A32),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "お問い合わせフォーム",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
