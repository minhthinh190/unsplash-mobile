import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:unsplash_mobile/screens/signin.dart';
import 'package:unsplash_mobile/widgets/appbar.dart';
import 'package:unsplash_mobile/widgets/bottom_bar.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MyProfile extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xff323232)),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(horizontal: 60, vertical: 10),
            ),
          ),

          child: Text(
            'Sign out',
            style: TextStyle(
              fontSize: 20,
            ),
          ),

          onPressed: () async {
            final User user = _auth.currentUser;
            await _signOut();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${user.email} signed out')),
            );

            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => SignInPage(),
            ));
          },
        )
      ),
      bottomNavigationBar: BottomBar(selectedIndex: 3),
    );
  }

  Future<void> _signOut() async {
    await _auth.signOut();
  }
}