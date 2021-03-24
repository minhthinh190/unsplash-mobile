import 'package:flutter/material.dart';
import 'package:unsplash_mobile/widgets/appbar.dart';

class Home extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: const Center(
        child: const Text('Welcome to Unsplash!'),
      ),
    );
  }
}