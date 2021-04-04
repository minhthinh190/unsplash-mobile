import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:unsplash_mobile/model/photo.dart';
import 'package:unsplash_mobile/data/api.dart';

class RecommendedList extends StatefulWidget {
  @override 
  _RecommendedListState createState() => _RecommendedListState();
}

class _RecommendedListState extends State<RecommendedList> {
  List<Photo> photos = new List();
  
  getRecommendedPhotos() async {
    final response = await http.get(
      "https://api.pexels.com/v1/curated?page=10&per_page=4",
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

  @override 
  void initState() {
    super.initState();
    getRecommendedPhotos();
  }

  @override 
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 30),
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: <Widget>[
          Container(
            width: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(photos[0].src.portrait, fit: BoxFit.cover),
            ),
          ),
          Container(
            width: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(photos[1].src.portrait, fit: BoxFit.cover),
            ),
          ),
          Container(
            width: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(photos[2].src.portrait, fit: BoxFit.cover),
            ),
          ),
          Container(
            width: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(photos[3].src.portrait, fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}