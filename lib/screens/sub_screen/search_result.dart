import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:unsplash_mobile/data/api.dart';
import 'package:unsplash_mobile/model/photo.dart';
import 'package:unsplash_mobile/widgets/photo_list.dart';

class SearchResult extends StatefulWidget {
  final String query;
  List<UnsplashPhoto> photos;
  SearchResult({@required this.query, @required this.photos});

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
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
      'query': widget.query,
    };
    String query = Uri(queryParameters: queryParams).query;
    var url = Uri.parse(unsplashSearch + query);

    final response = await http.get(
      url,
      headers: {'Authorization': unsplashApiKey},
    );
    if (response.body.isNotEmpty) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      
      jsonData['results'].forEach((element) {
        UnsplashPhoto photo = new UnsplashPhoto();
        photo = UnsplashPhoto.fromMap(element);
        widget.photos.add(photo);
      });
    }

    setState(() {
      isLoading = !isLoading;
      widget.photos = widget.photos;
    });
  }

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController(initialScrollOffset: 5.0)..addListener(_scrollListener);
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,

          child: Container(
            margin: EdgeInsets.only(top: 40, bottom: 10),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  width: double.infinity,
                  
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0, 
                        left: 0,

                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 33, height: 33,
                            child: Icon(Icons.arrow_back, color: Color(0xff323232)),
                          ),
                        )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            widget.query.inCaps,
                            style: TextStyle(
                              fontSize: 30, 
                              fontWeight: FontWeight.bold,
                              color: Color(0xff323232)
                            ),
                          ),
                        ],
                      )  
                    ]
                  ),
                ),
                SizedBox(height: 10),
                photoList(photos: widget.photos, context: context),
                _loader(),
              ],
            ),
          ),
        ),
      ),
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

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach => this.split(" ").map((str) => str.inCaps).join(" ");
}