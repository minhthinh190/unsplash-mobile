import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:unsplash_mobile/widgets/appbar.dart';
import 'package:unsplash_mobile/widgets/bottom_bar.dart';
import 'package:unsplash_mobile/widgets/search_field.dart';
import 'package:unsplash_mobile/widgets/trending_list.dart';
import 'package:unsplash_mobile/widgets/recommended_list.dart';

import 'package:unsplash_mobile/data/api.dart';
import 'package:unsplash_mobile/model/photo.dart';
import 'package:unsplash_mobile/screens/search_result.dart';

class Search extends StatefulWidget {
  final String searchQuery;
  Search({this.searchQuery});

  @override 
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Photo> photos = new List();
  List<Photo> trendingPhotos = new List();

  TextEditingController searchController = new TextEditingController();

  getTrendingPhotos() async {
    final response = await http.get(
      "https://api.pexels.com/v1/curated?page=30&per_page=5",
      headers: {"Authorization": apiKey},
    );

    List<Photo> photos = new List();

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      Photo photo = new Photo();
      photo = Photo.fromMap(element);
      photos.add(photo);
    });

    setState(() { trendingPhotos = photos; });
  }

  getSearchedPhotos(String query) async {
    final response = await http.get(
      "https://api.pexels.com/v1/search?query=$query&per_page=16",
      headers: {"Authorization": apiKey},
    );

    photos.clear();
    List<Photo> newPhotos = new List();

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      Photo photo = new Photo();
      photo = Photo.fromMap(element);
      newPhotos.add(photo);
    });

    setState(() { photos = newPhotos; });
    displayResultScreen(query);
  }

  displayResultScreen(String query) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResult(query: query, photos: photos)
      )
    );
  }

  @override 
  void initState() {
    super.initState();
    getTrendingPhotos();
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SearchField(controller: searchController, callback: getSearchedPhotos),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 30),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Trending searches',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )
                  ),
                  trendingList(photos: trendingPhotos),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 35),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 30),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Trending topics',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )
                  ),
                  categoryList(items: ['People', 'Architecture', 'Space', 'Current Events'], callback: getSearchedPhotos),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Column(  
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 30),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Recommended for you',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )
                  ),
                  RecommendedList(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(selectedIndex: 1),
    );
  }
}

Widget categoryList({List<String> items, Function(String) callback, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),

    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            trendingTopic(title: items[0], callback: callback),
            trendingTopic(title: items[1], callback: callback),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: <Widget>[
            trendingTopic(title: items[2], callback: callback),
            trendingTopic(title: items[3], callback: callback),
          ],
        ),
      ],
    )
  );
}

Widget trendingTopic({String title, Function(String) callback, context}) {
  return GestureDetector(
    onTap: () {
      callback(title);
    },
    
    child: Container(
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
      alignment: Alignment.center,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Color(0xffececec),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff808080)),
      ),
    )
  );
}