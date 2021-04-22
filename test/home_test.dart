import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:unsplash_mobile/widgets/home/topic_list.dart';
import 'package:unsplash_mobile/screens/home.dart';

void main() {
  testWidgets('Display topic list at home screen', (WidgetTester tester) async {
    final childWidget = TopicList(items: ['1', '2', '3'], callback: null);

    // Create the widget
    await tester.pumpWidget(Home());

    // Create the Finders
    expect(find.byWidget(childWidget), findsOneWidget);
  });

  testWidgets('Display column at home screen', (WidgetTester tester) async {
    final childWidget = Column();

    // Create the widget
    await tester.pumpWidget(Home());

    // Create the Finders
    expect(find.byWidget(childWidget), findsOneWidget);
  });
  
  testWidgets('Display container at home screen', (WidgetTester tester) async {
    final childWidget = Container();

    // Create the widget
    await tester.pumpWidget(Home());

    // Create the Finders
    expect(find.byWidget(childWidget), findsOneWidget);
  });
}
