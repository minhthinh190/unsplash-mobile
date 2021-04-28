import 'package:flutter/material.dart';
import 'package:unsplash_mobile/model/photo.dart';

import 'package:unsplash_mobile/screens/sub_screen/selected_image.dart';

Widget photoList({List<UnsplashPhoto> photos, context}) {
  return Container(
    padding: EdgeInsets.only(top: 20, right: 30, left: 30, bottom: 20),

    child: GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      physics: ClampingScrollPhysics(),
      childAspectRatio: 1,
      mainAxisSpacing: 20.0,
      crossAxisSpacing: 15.0,

      children: photos.map((photo) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => SelectedImage(
                author: photo.author,
                imageSrc: photo.source.regular,
              ))
            );
          },
          child: GridTile(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(photo.source.thumb, fit: BoxFit.cover),
            ),
          )
        );
      }).toList(),
    ),
  );
}