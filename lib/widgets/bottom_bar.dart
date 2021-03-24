import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.photo_library_rounded),
          label: 'Home',
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_rounded),
          label: 'Search',
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.upload_sharp),
          label: 'Upload',
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: 'Profile',
          backgroundColor: Colors.blue,
        ),
      ],
    );
  }
}