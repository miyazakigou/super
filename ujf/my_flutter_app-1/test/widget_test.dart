import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_flutter_app/src/app.dart';

void main() {
  testWidgets('App has a title', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final titleFinder = find.text('My Flutter App');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('Home screen displays content', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final homeScreenFinder = find.byType(HomeScreen);
    expect(homeScreenFinder, findsOneWidget);
  });
}