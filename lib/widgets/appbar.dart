import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override 
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      //title: const Text('Unsplash'),
      title: Image.asset(
        'assets/images/unsplash_logo.png', 
        height: 30,
      ),
    );
  }

  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}