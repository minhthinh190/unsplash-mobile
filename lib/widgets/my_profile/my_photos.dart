import 'package:flutter/material.dart';
import 'package:unsplash_mobile/model/photo.dart';

import 'package:unsplash_mobile/screens/sub_screen/selected_image.dart';

Widget myPhotos({context}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 30),

    child: GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1,
      physics: ClampingScrollPhysics(),
      mainAxisSpacing: 7,
      crossAxisSpacing: 7,

      children: <Widget>[
        /*
        GestureDetector(
          child: GridTile(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network('https://avatarfiles.alphacoders.com/253/thumb-253160.jpg', fit: BoxFit.cover),
            ),
          ),
        ),
        GestureDetector(
          child: GridTile(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network('https://avatarfiles.alphacoders.com/253/thumb-253160.jpg', fit: BoxFit.cover),
            ),
          ),
        ),
        GestureDetector(
          child: GridTile(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network('https://avatarfiles.alphacoders.com/253/thumb-253160.jpg', fit: BoxFit.cover),
            ),
          ),
        ),
        */
      ],
      /*
      children: photos.map((photo) {
        return GestureDetector(
          child: GridTile(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network('https://avatarfiles.alphacoders.com/253/thumb-253160.jpg', fit: BoxFit.cover),
            ),
          ),
        );
      }).toList(),*/
    ),
  );
}