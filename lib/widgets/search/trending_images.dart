import 'package:flutter/material.dart';
import 'package:unsplash_mobile/model/photo.dart';

import 'package:unsplash_mobile/screens/selected_image.dart';

Widget trendingImages({List<UnsplashPhoto> photos, context}) {
  return Container(
    height: 130,
    margin: EdgeInsets.only(top: 20),
    
    child: ListView.builder(
      itemCount: photos.length,
      scrollDirection: Axis.horizontal,

      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => SelectedImage(
                author: photos[index].author,
                imageSrc: photos[index].source.regular,
              ))
            );
          },

          child: Container(
            width: 105,
            margin: index == 0 ? 
              EdgeInsets.only(left: 30, right: 15) : EdgeInsets.only(right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(photos[index].source.small, fit: BoxFit.cover),
            ),
          )
        );
      },
    ),
  );
}