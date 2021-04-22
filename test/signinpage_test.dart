import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:unsplash_mobile/screens/signin.dart';

void main() {
  testWidgets('Display sign in screen', (WidgetTester tester) async {
    final childWidget = SignInPage();

    await tester.pumpWidget(MaterialApp(
      home: childWidget,
    ));

    expect(find.byWidget(childWidget), findsOneWidget);
  });
  
  testWidgets('Test displaying Welcome title', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Text('Welcome,'),
      ),
    ));

    expect(find.text('Welcome,'), findsOneWidget);
  });

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