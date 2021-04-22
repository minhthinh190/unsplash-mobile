import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:unsplash_mobile/screens/search.dart';

import 'package:unsplash_mobile/model/photo.dart';
import 'package:unsplash_mobile/widgets/search/trending_images.dart';
import 'package:unsplash_mobile/widgets/search/trending_topics.dart';
import 'package:unsplash_mobile/widgets/search/recommended_images.dart';

void main() {
  testWidgets('Test displaying search screen', (WidgetTester tester) async {
    final childWidget = Search();

    await tester.pumpWidget(MaterialApp(
      home: childWidget,
    ));

    expect(find.byWidget(childWidget), findsOneWidget);
  });

  testWidgets('Test displaying trending images widget', (WidgetTester tester) async {
    List<UnsplashPhoto> photos;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Container(
          child: trendingImages(photos: photos),
        ),
      ),
    ));

    expect(find.byWidget(trendingImages()), findsOneWidget);
  });

  testWidgets('Test recommended images widget', (WidgetTester tester) async {
          final recommendedImages = RecommendedImages();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Container(
          child: recommendedImages,
        ),
      ),
    ));

    expect(find.byWidget(recommendedImages), findsOneWidget);
  });
}