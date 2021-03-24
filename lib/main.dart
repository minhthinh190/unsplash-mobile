import 'package:flutter/material.dart';
import 'package:unsplash_mobile/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unsplash',
      theme: ThemeData(primaryColor: Colors.white),
      home: Home(),
    );
  }
}