// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:zikzak_useragent_example/main.dart';

void main() {
  testWidgets('Verify Platform UserAgent', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that platform version is retrieved.
    //
    // The stock plugin template asserted `widget.data!.startsWith('')`, which
    // matches EVERY Text in the tree. The example app renders a second Text
    // (the AppBar title), so that finder found two widgets and the test was
    // red on master before this fix. Scope the finder to the body, which
    // holds the one Text that carries the platform UserAgent.
    expect(
      find.descendant(
        of: find.byType(Center),
        matching: find.byType(Text),
      ),
      findsOneWidget,
    );
  });
}
