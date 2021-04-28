import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unsplash_mobile/widgets/appbar.dart';
import 'package:unsplash_mobile/widgets/bottom_bar.dart';
import 'package:unsplash_mobile/widgets/home/topic_list.dart';
import 'package:unsplash_mobile/widgets/photo_list.dart';

import 'package:unsplash_mobile/data/api.dart';
import 'package:unsplash_mobile/model/photo.dart';

class Home extends StatefulWidget {
  @override 
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<UnsplashPhoto> photos = <UnsplashPhoto>[];
  List<String> items = ['Wallpapers', 'Nature', 'People', 'Architecture', 'Current Event', 'Fashion', 'Travel']; 
  
  ScrollController scrollController;
  int currentPage = 1;
  bool isLoading = false;

  // Infinite scrolling feature
  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent) {
      startLoader();
    }
  }

  void startLoader() {
    setState(() {
      isLoading = !isLoading;
      loadMore();
    });
  }

  loadMore() async {
    setState(() {
      currentPage = currentPage + 1;
    });

    Map<String, String> queryParams = {
      'page': currentPage.toString(),
      'per_page': '10',
      'order_by': 'latest',
    };
    String query = Uri(queryParameters: queryParams).query;
    var url = Uri.parse(unsplashPhotos + query);

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

    setState(() {
      isLoading = !isLoading;
      photos = photos;
    });
  }

  getLatestPhotos() async {
    Map<String, String> queryParams = {
      'page': currentPage.toString(),
      'per_page': '20',
      'order_by': 'latest',
    };
    String query = Uri(queryParameters: queryParams).query;
    var url = Uri.parse(unsplashPhotos + query);

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

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData['results'].forEach((element) {
      UnsplashPhoto photo = new UnsplashPhoto();
      photo = UnsplashPhoto.fromMap(element);
      photos.add(photo);
    });

    setState(() {});
  }

  @override 
  void initState() {
    super.initState();
    scrollController = new ScrollController(initialScrollOffset: 5.0)..addListener(_scrollListener);
    getLatestPhotos();
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: new MyAppBar(),
      body: new SingleChildScrollView(
        controller: scrollController,

        child: Container(
          child: Column(
            children: <Widget>[
              TopicList(items: items, callback: getSearchedPhotos),
              photoList(photos: photos, context: context),
              _loader(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(selectedIndex: 0),
    );
  }

  Widget _loader() {
    return isLoading ?
      new Align(
        child: new Container(
          width: 40,
          height: 40,
          child: new Padding(
            padding: const EdgeInsets.all(5),
            child: new Center(
              child: new CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff323232)),
              )
            ),
          ),
        ),
        alignment: FractionalOffset.bottomCenter,
      )
      :
      new SizedBox(width: 0, height: 0);
  }
}