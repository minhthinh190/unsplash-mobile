import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_upward),
          label: 'Upload',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.circle),
          label: 'Profile',
        ),
      ],
    );
  }
}