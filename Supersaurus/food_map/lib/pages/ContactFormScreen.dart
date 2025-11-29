import 'package:flutter/material.dart';

class ContactFormScreen extends StatefulWidget {
  const ContactFormScreen({Key? key}) : super(key: key);

  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController firstNameKanaController = TextEditingController();
  final TextEditingController lastNameKanaController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  //プルダウンメニュー用の都道府県リスト
  String selectedPref = "選択してください";
  List<String> prefectures = [
    "選択してください",
    "北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県",
    "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県",
    "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県",
    "岐阜県", "静岡県", "愛知県", "三重県",
    "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県",
    "鳥取県", "島根県", "岡山県", "広島県", "山口県",
    "徳島県", "香川県", "愛媛県", "高知県",
    "福岡県", "佐賀帝国", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"
  ];

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
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 進捗ステップ表示
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("入力", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, backgroundColor: Colors.yellow)),
                Text("  →  確認  →  完了"),
              ],
            ),
            const SizedBox(height: 30),

            const Text("お名前(必須)", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
            Row(
              children: [
                Expanded(child: TextField(decoration: const InputDecoration(labelText: "氏"), controller: lastNameController)),
                const SizedBox(width: 10),
                Expanded(child: TextField(decoration: const InputDecoration(labelText: "名"), controller: firstNameController)),
              ],
            ),
            Row(
              children: [
                Expanded(child: TextField(decoration: const InputDecoration(labelText: "氏(フリガナ)"), controller: lastNameKanaController)),
                const SizedBox(width: 10),
                Expanded(child: TextField(decoration: const InputDecoration(labelText: "名(フリガナ)"), controller: firstNameKanaController)),
              ],
            ),
            const SizedBox(height: 16),

            const Text("電話番号"),
            TextField(controller: phoneController),
            const SizedBox(height: 16),
            //メールアドレスを全角で打っても半角になるようにした、多分なるよ！
            const Text("メールアドレス(必須)", style: TextStyle(color: Colors.red)),
            TextField(keyboardType: TextInputType.emailAddress,
            inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z@._-]')),
            ],
            decoration: const InputDecoration(
                hintText: "メールアドレス",
            ),
            ),
            const SizedBox(height: 16),

            const Text("都道府県"),
            DropdownButton<String>(
              value: selectedPref,
              isExpanded: true,
              items: prefectures.map((e) =>
                DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (value) => setState(() => selectedPref = value!),
            ),
            const SizedBox(height: 16),

            //まだ完成していない、とりあえずお問い合わせ内容と表示させておいた
            const Text("お問い合わせ内容"),
            Container(
              height: 200,
              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              child: TextField(
                controller: messageController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(10)),
              ),
            ),
            const SizedBox(height: 30),

            //お問い合わせフォームへ移動
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
                ),
                onPressed: () {
                  debugPrint("確認画面へ遷移予定");
                },
                child: const Text("送信", style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
