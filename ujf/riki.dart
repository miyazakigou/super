import "dart:math";
import 'dart:io';

void main() {
  final int a = Random.secure().nextInt(100);
  print('0〜99の数字を当ててください');

  while (true) {
    stdout.write('入力してください: ');
    String? input = stdin.readLineSync();
    if (input == null) {
      print('入力が読み取れませんでした。終了します。');
      break;
    }

    final int? guess = int.tryParse(input);
    if (guess == null) {
      print('数値を入力してください。');
      continue;
    }

    if (guess == a) {
      print('あたり');
      break;
    } else if (guess < a) {
      print('もっと大きい数字です');
    } else {
      print('もっと小さい数字です');
    }
  }
}