import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unsplash_mobile/widgets/appbar.dart';
import 'package:unsplash_mobile/widgets/bottom_bar.dart';
import 'package:unsplash_mobile/widgets/search_field.dart';

import 'package:unsplash_mobile/data/api.dart';
import 'package:unsplash_mobile/model/photo.dart';
import 'package:unsplash_mobile/widgets/photo_list.dart';

class Search extends StatefulWidget {
  final String searchQuery;
  Search({this.searchQuery});

  @override 
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Photo> photos = new List();

  TextEditingController searchController = new TextEditingController();

  getNewPhotos() async {
    final response = await http.get(
      newPhotos,
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
    getSearchedPhotos(widget.searchQuery);
    searchController.text = widget.searchQuery;
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SearchField(controller: searchController, callback: getSearchedPhotos),
              photoList(photos: photos, context: context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(selectedIndex: 1),
    );
  }
}