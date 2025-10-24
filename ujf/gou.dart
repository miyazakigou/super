import 'dart:io';
import 'dart:math';

void main() {
  int num = Random().nextInt(101);

  stdout.write("あなたの予想した数字を入力してください：");
  String? line = stdin.readLineSync();
  int? sentence = (line != null) ? int.tryParse(line) : null;

  if (sentence == null) {
    print("正しい整数を入力してください。");
    return;
  }

  reverseSentence(num, sentence);
}
void reverseSentence(int num, int sentence) {
  if (num == sentence) {
    print("おめでとうございます！正解です！");
  } else if (num > sentence) {
    print("あなたの予想した数字は小さすぎます。");
  } else {
    print("あなたの予想した数字は大きすぎます。");
  }
}