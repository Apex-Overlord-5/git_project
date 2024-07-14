// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rubesh_quiz_app/main.dart';  // Ensure the correct import path to main.dart

void main() {
  testWidgets('Quiz app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(QuizApp());

    // Verify that the initial state of the quiz is displayed.
    expect(find.text('What is the capital of France?'), findsOneWidget);
    expect(find.text('Roll Rubesh\'s Dice'), findsNothing);

    // Tap the first answer and trigger a frame.
    await tester.tap(find.text('Paris'));
    await tester.pump();

    // Verify that the next question is displayed.
    expect(find.text('Who wrote "Hamlet"?'), findsOneWidget);
    expect(find.text('What is the capital of France?'), findsNothing);
  });
}
