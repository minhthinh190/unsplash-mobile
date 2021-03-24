import 'package:flutter/material.dart';
import 'package:unsplash_mobile/widgets/appbar.dart';
import 'package:unsplash_mobile/widgets/bottom_bar.dart';

class Upload extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: const Center(
        child: const Text('Upload Screen'),
      ),
      bottomNavigationBar: BottomBar(selectedIndex: 2),
    );
  }
}