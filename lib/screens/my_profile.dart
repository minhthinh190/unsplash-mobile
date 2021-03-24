import 'package:flutter/material.dart';
import 'package:unsplash_mobile/widgets/appbar.dart';

class MyProfile extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: const Center(
        child: const Text('My Profile Screen'),
      ),
    );
  }
}