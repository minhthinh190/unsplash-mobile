import 'package:flutter/material.dart';
import 'package:unsplash_mobile/screens/home.dart';
import 'package:unsplash_mobile/screens/search.dart';
import 'package:unsplash_mobile/screens/upload.dart';
import 'package:unsplash_mobile/screens/my_profile.dart';

class BottomBar extends StatelessWidget {
  final int selectedIndex;

  BottomBar({Key key, @required this.selectedIndex}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      switch(index) {
        case 0:
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
          break;
        case 1:
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Search()),
          );
          break;
        case 2:
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Upload()),
          );
          break;
        case 3:
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyProfile()),
          );
          break;
      }
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xff323232),
      unselectedItemColor: Color(0xffbababa),
      showSelectedLabels: false,
      showUnselectedLabels: false,

      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.photo_library_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_rounded),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.upload_sharp),
          label: 'Upload',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: _onItemTapped,
    );
  }
}