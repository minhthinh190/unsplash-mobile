import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:unsplash_mobile/widgets/user_profile/user_photos.dart';

import 'package:unsplash_mobile/data/api.dart';
import 'package:unsplash_mobile/model/photo.dart';

class UserProfile extends StatefulWidget {
  final User user;
  UserProfile({@required this.user});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  List<UnsplashPhoto> photos = new List();

  getUserPhotos() async {
    Map<String, String> queryParams = {
      'page': '1',
      'per_page': '20',
      'order_by': 'latest',
    };
    String query = Uri(queryParameters: queryParams).query;
    var url = Uri.parse('https://api.unsplash.com/users/' + widget.user.username + '/photos?' + query);

    final response = await http.get(
      url,
      headers: {'Authorization': unsplashApiKey},
    );

    if (response.body.isNotEmpty) {
      List<dynamic> jsonData = jsonDecode(response.body);
      
      jsonData.forEach((element) {
        UnsplashPhoto photo = new UnsplashPhoto();
        photo = UnsplashPhoto.fromMap(element);
        photos.add(photo);
      });
    }
    setState(() {});
  }

  @override 
  void initState() {
    super.initState();
    getUserPhotos();
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 30, left: 30, right: 30),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 33, height: 33,
                    child: Icon(Icons.arrow_back, color: Color(0xff323232)),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10),

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            widget.user.profileImage,
                            width: 90, height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25),
                        width: 220,

                        child: Text(
                          widget.user.name,
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xff323232)),
                        ),
                      ),
                    ],
                  )
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.user.totalPhotos.toString(),
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xff323232)),
                    ),
                    Text(
                      ' photos',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xffbababa)),
                    ),
                  ],
                ),
                userPhotos(photos: photos, context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}