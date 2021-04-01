import 'package:flutter/material.dart';

import 'package:unsplash_mobile/model/photo.dart';
import 'package:unsplash_mobile/widgets/appbar.dart';
import 'package:unsplash_mobile/widgets/photo_list.dart';

class SearchResult extends StatelessWidget {
  final String query;
  final List<Photo> photos;

  SearchResult({@required this.query, @required this.photos});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 20),

          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30, bottom: 10),

                child: Text(
                  this.query.inCaps,
                  style: TextStyle(
                    fontSize: 30, 
                    fontWeight: FontWeight.bold,
                    color: Color(0xff323232)
                  ),
                ),
              ),
              photoList(photos: photos, context: context),
            ],
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