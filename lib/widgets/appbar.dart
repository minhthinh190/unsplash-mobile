import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override 
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Image.asset(
        'assets/images/unsplash_logo.png', 
        height: 30,
      ),
      elevation: 0,
    );
  }

  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}