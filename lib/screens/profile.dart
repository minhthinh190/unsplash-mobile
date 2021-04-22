import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:unsplash_mobile/widgets/profile/profile_photo_list.dart';
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
                padding: EdgeInsets.symmetric(horizontal: 30),

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
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text('${data['total_photos']}', 
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xff323232))
                              ),
                              Text('Pics', 
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xffbababa)),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text('${data['followers_count']}', 
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xff323232))
                              ),
                              Text('Followers', 
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xffbababa))
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text('${data['following_count']}', 
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xff323232))
                              ),
                              Text('Following', 
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xffbababa))
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,

                        children: <Widget>[
                          GestureDetector(
                            child: Icon(Icons.apps, color: Color(0xffdcdcdc), size: 32),
                          ),
                          GestureDetector(
                            child: Icon(Icons.favorite, color: Color(0xffdcdcdc), size: 32),
                          ),
                          GestureDetector(
                            child: Icon(Icons.add_to_photos, color: Color(0xffdcdcdc), size: 32),
                          ),
                        ],
                      ),
                    ),
                    profilePhotoList(context: context),
                  ],
                ),
              ),
            );
          }

          return Text('Loading');
        }
      ),
      bottomNavigationBar: BottomBar(selectedIndex: 3),
    );
  }
}