import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override 
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
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

class MyProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function callback;
  MyProfileAppBar({@required this.callback});

  @override 
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Color(0xff323232)),
      centerTitle: true,
      title: Image.asset(
        'assets/images/unsplash_logo.png', 
        height: 30,
      ),
      elevation: 0,
      actions: <Widget>[
        PopupMenuButton(
          onSelected: (value) {
            this.callback();
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(Icons.logout, color: Color(0xff323232)),
                    Text('Sign out', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff323232))),
                  ],
                ),
              ), 
              value: 'option1',
            ),
          ],
        ),
      ],
    );
  }

  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}