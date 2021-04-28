import 'package:flutter/material.dart';

import 'package:unsplash_mobile/model/photo.dart';
import 'package:unsplash_mobile/widgets/photo_list.dart';

class SearchResult extends StatelessWidget {
  final String query;
  final List<UnsplashPhoto> photos;

  SearchResult({@required this.query, @required this.photos});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                            this.query.inCaps,
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
                photoList(photos: photos, context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach => this.split(" ").map((str) => str.inCaps).join(" ");
}