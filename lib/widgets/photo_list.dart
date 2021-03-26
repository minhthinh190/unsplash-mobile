import 'package:flutter/material.dart';
import 'package:unsplash_mobile/model/photo.dart';

Widget photoList({List<Photo> photos, context}) {
  return Container(
    margin: EdgeInsets.only(top: 20, right: 0, left: 0, bottom: 20),
    padding: EdgeInsets.symmetric(horizontal: 30),

    child: GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      physics: ClampingScrollPhysics(),
      childAspectRatio: 0.9,
      mainAxisSpacing: 20.0,
      crossAxisSpacing: 15.0,

      children: photos.map((photo) {
        return GridTile(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(photo.src.portrait, fit: BoxFit.cover,),
          ),
        );
      }).toList(),
    ),
  );
}