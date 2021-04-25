import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:unsplash_mobile/screens/sub_screen/signin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initializeFlutterFire() async { 
    await Firebase.initializeApp();
  }

  @override 
  void initState() {
    super.initState();
    initializeFlutterFire();
  }

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unsplash',
      home: SignInPage(),
    );
  }
}