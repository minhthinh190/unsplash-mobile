import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:unsplash_mobile/widgets/appbar.dart';
import 'package:unsplash_mobile/widgets/bottom_bar.dart';
import 'package:unsplash_mobile/widgets/search/search_field.dart';
import 'package:unsplash_mobile/widgets/search/trending_images.dart';
import 'package:unsplash_mobile/widgets/search/trending_topics.dart';
import 'package:unsplash_mobile/widgets/search/recommended_images.dart';

import 'package:unsplash_mobile/data/api.dart';
import 'package:unsplash_mobile/model/photo.dart';
import 'package:unsplash_mobile/screens/sub_screen/search_result.dart';

class Search extends StatefulWidget {
  final String searchQuery;
  Search({this.searchQuery});

  @override 
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<UnsplashPhoto> photos = <UnsplashPhoto>[];
  List<UnsplashPhoto> trendingPhotos = <UnsplashPhoto>[];

  TextEditingController searchController = new TextEditingController();

  getTrendingPhotos() async {
    Map<String, String> queryParams = {
      'page': '1',
      'per_page': '5',
      'order_by': 'popular',
    };
    String query = Uri(queryParameters: queryParams).query;
    var url = Uri.parse(unsplashPhotos + query);

    final response = await http.get(
      url,
      headers: {'Authorization': unsplashApiKey},
    );
    List<UnsplashPhoto> newPhotos = <UnsplashPhoto>[];

    if (response.body.isNotEmpty) {
      List<dynamic> jsonData = jsonDecode(response.body);
      jsonData.forEach((element) {
        UnsplashPhoto photo = new UnsplashPhoto();
        photo = UnsplashPhoto.fromMap(element);
        newPhotos.add(photo);
      }); 

      setState(() { trendingPhotos = newPhotos; });
    }
  }

  getSearchedPhotos(String input) async {
    Map<String, String> queryParams = {
      'page': '1',
      'per_page': '16',
      'query': input,
    };
    String query = Uri(queryParameters: queryParams).query;
    var url = Uri.parse(unsplashSearch + query);

    final response = await http.get(
      url,
      headers: {'Authorization': unsplashApiKey},
    );
    photos.clear();
    List<UnsplashPhoto> newPhotos = <UnsplashPhoto>[];

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData['results'].forEach((element) {
      UnsplashPhoto photo = new UnsplashPhoto();
      photo = UnsplashPhoto.fromMap(element);
      newPhotos.add(photo);
    });

    setState(() { photos = newPhotos; });
    displayResultScreen(input);
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
      backgroundColor: Colors.white,

      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Container(
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
                    trendingImages(photos: trendingPhotos),
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
                    trendingTopics(items: ['Interiors', 'Patterns', 'Textures', 'History'], callback: getSearchedPhotos),
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
                    RecommendedImages(),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
      bottomNavigationBar: BottomBar(selectedIndex: 1),
    );
  }
}