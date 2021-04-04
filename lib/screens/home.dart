import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unsplash_mobile/widgets/appbar.dart';
import 'package:unsplash_mobile/widgets/bottom_bar.dart';
import 'package:unsplash_mobile/widgets/topic_list.dart';

import 'package:unsplash_mobile/data/api.dart';
import 'package:unsplash_mobile/model/photo.dart';
import 'package:unsplash_mobile/widgets/photo_list.dart';

class Home extends StatefulWidget {
  @override 
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Photo> photos = new List();
  List<String> items = ['Wallpapers', 'Nature', 'People', 'Architecture', 'Current Event', 'Fashion', 'Travel']; 
 
  getNewPhotos() async {
    final response = await http.get(
      "https://api.pexels.com/v1/curated?per_page=16",
      headers: {"Authorization": apiKey},
    );

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      Photo photo = new Photo();
      photo = Photo.fromMap(element);
      photos.add(photo);
    });

    setState(() {});
  }

  getSearchedPhotos(String query) async {
    final response = await http.get(
      "https://api.pexels.com/v1/search?query=$query&per_page=16",
      headers: {"Authorization": apiKey},
    );

    photos.clear();
    
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      Photo photo = new Photo();
      photo = Photo.fromMap(element);
      photos.add(photo);
    });

    setState(() {});
  }

  @override 
  void initState() {
    super.initState();
    getNewPhotos();
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              TopicList(items: items, callback: getSearchedPhotos),
              photoList(photos: photos, context: context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(selectedIndex: 0),
    );
  }
}