import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_flutter_app/main.dart';

void main() {
  testWidgets('MyApp has a title and message', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final titleFinder = find.text('Flutter Demo Home Page');
    final messageFinder = find.text('Hello, Flutter!');

    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
}