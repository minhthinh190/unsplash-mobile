import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:unsplash_mobile/model/photo.dart';
import 'package:unsplash_mobile/data/api.dart';

import 'package:unsplash_mobile/screens/selected_image.dart';

class RecommendedImages extends StatefulWidget {
  @override 
  _RecommendedImagesState createState() => _RecommendedImagesState();
}

class _RecommendedImagesState extends State<RecommendedImages> {
  List<UnsplashPhoto> photos = new List();


  getRecommendedPhotos() async {
    final rnd = new Random();
    String randomPage = rnd.nextInt(100 - 2).toString();

    Map<String, String> queryParams = {
      'page': randomPage,
      'per_page': '4',
      'order_by': 'popular',
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

      setState(() {});
    }
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
      
      child: photos.length != 0 ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => SelectedImage(
                  author: photos[0].author,
                  imageSrc: photos[0].source.regular,
                ))
              );
            },
            child: Container(
              width: 80,
              height: 80,

              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(photos[0].source.small, fit: BoxFit.cover),
              ),
            )
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => SelectedImage(
                  author: photos[1].author,
                  imageSrc: photos[1].source.regular,
                ))
              );
            },
            child: Container(
              width: 80,
              height: 80,

              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(photos[1].source.small, fit: BoxFit.cover),
              ),
            )
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => SelectedImage(
                  author: photos[2].author,
                  imageSrc: photos[2].source.regular,
                ))
              );
            },
            child: Container(
              width: 80,
              height: 80,

              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(photos[2].source.small, fit: BoxFit.cover),
              ),
            )
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => SelectedImage(
                  author: photos[3].author,
                  imageSrc: photos[3].source.regular,
                ))
              );
            },
            child: Container(
              width: 80,
              height: 80,

              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(photos[3].source.small, fit: BoxFit.cover),
              ),
            )
          ),
        ],
      )
      :
      Row(
        children: <Widget>[
          Text(''),
        ],
      ),
    );
  }
}