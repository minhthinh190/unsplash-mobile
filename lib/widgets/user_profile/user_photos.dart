import 'package:flutter/material.dart';
import 'package:unsplash_mobile/model/photo.dart';

import 'package:unsplash_mobile/screens/sub_screen/selected_image.dart';

Widget userPhotos({List<UnsplashPhoto> photos, context}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 30),

    child: GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1,
      physics: ClampingScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,

      children: photos.map((photo) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => SelectedImage(
                author: photo.author,
                imageSrc: photo.source.regular,
              )
            ));
          },

          child: GridTile(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(photo.source.thumb, fit: BoxFit.cover),
            ),
          ),
        );
      }).toList(),
    ),
  );
}