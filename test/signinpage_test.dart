import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:unsplash_mobile/screens/signin.dart';

void main() {
  // Test case 1
  testWidgets('Display sign in screen', (WidgetTester tester) async {
    final childWidget = SignInPage();

    await tester.pumpWidget(MaterialApp(
      home: childWidget,
    ));

    expect(find.byWidget(childWidget), findsOneWidget);
  });
  
  // Test case 2
  testWidgets('Test displaying Welcome title', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Text('Welcome,'),
      ),
    ));

    expect(find.text('Welcome,'), findsOneWidget);
  });

  // Test case 3
  testWidgets('Test displaying sigin instruction', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Container(
          child: Text('Sign in to continue!'),
        ),
      ),
    ));

    expect(find.text('Sign in to continue!'), findsOneWidget);
  });
  
  // Test case 4
  testWidgets('description', (WidgetTester tester) async {
    await tester.pumpWidget(Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            key: Key('email'),
          ),
          TextFormField(
            key: Key('password'),
          )
        ],
      ),
    ));

    final emailField = find.byKey(Key('email'));
    final passwordField = find.byKey(Key('password'));

    await tester.enterText(emailField, 'user1@email.com');
    await tester.enterText(passwordField, '123456789');
  });
}