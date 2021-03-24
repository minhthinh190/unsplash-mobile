import 'package:flutter/material.dart';
import 'package:unsplash_mobile/widgets/appbar.dart';
import 'package:unsplash_mobile/widgets/bottom_bar.dart';

class Search extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: const Center(
        child: const Text('Search Screen'),
      ),
      bottomNavigationBar: BottomBar(selectedIndex: 1),
    );
  }
}