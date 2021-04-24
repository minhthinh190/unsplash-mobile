import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:unsplash_mobile/widgets/profile/my_photos.dart';
import 'package:unsplash_mobile/widgets/appbar.dart';
import 'package:unsplash_mobile/widgets/bottom_bar.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Profile extends StatefulWidget {
  @override 
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override 
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('Users');

    return Scaffold(
      appBar: MyAppBar(),
      body: FutureBuilder<DocumentSnapshot> ( 
        future: user.doc('${_auth.currentUser.email}').get(),

        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong!');
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();

            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),

                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 10),

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              '${data['profile_image']}',
                              width: 90, height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 25),

                          child: Text(
                            '${data['name']}',
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xff323232)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    myPhotos(context: context),
                  ],
                ),
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff323232)),
            )
          );
        }
      ),
      bottomNavigationBar: BottomBar(selectedIndex: 3),
    );
  }
}