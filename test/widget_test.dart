// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:unit_testing_practice/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  group('Widget Tests', () {
    testWidgets('Playing with testing widgets', (WidgetTester tester) async {
      await tester.pumpWidget(TestWidget(title: "Title", message: "Message"));

      //Create the Finders.
      final titleFinder = find.text('Title');
      final messageFinder = find.text('Message');

      expect(titleFinder, findsOneWidget);

      expect(messageFinder, findsOneWidget);
    });

    testWidgets('find.byWidget Test', (WidgetTester tester) async {
      final testKey = Key('K');

      await tester.pumpWidget(TestWidget(
        title: "Title",
        message: "Message",
        key: testKey,
      ));

      expect(find.byType(Text), findsNWidgets(2));

      expect(find.byKey(testKey), findsOneWidget);
    });
  });

  group('Unit Tests', () {
    test('First Test', () {
      var result = Testtest().getOne();

      expect(result, 1);
    });

    test('Second Test', () {
      var result = Testtest().getString();

      expect(result, 'string?');
    });
  });
}

class TestWidget extends StatelessWidget {
  final String title;
  final String message;

  const TestWidget({Key key, @required this.title, @required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}

class Testtest {
  Testtest();

  int getOne() {
    return 1;
  }

  String getString() {
    return 'string?';
  }
}
