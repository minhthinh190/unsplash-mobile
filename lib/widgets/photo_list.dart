import 'package:flutter/material.dart';
import 'package:unsplash_mobile/model/photo.dart';

Widget photoList({List<Photo> photos, context}) {
  return Container(
    padding: EdgeInsets.only(top: 20, right: 30, left: 30, bottom: 20),

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