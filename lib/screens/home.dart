import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unsplash'),
      ),
      body: const Center(
        child: const Text('Welcome to Unsplash!'),
      ),
    );
  }
}