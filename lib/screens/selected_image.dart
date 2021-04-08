import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'package:unsplash_mobile/model/photo.dart';

class SelectedImage extends StatelessWidget {
  final User author;
  final String imageSrc;

  SelectedImage({@required this.author, @required this.imageSrc});

  downloadImage() async {
    final response = await http.get(imageSrc);

    // get the image name
    final imageName = path.basename(imageSrc);

    // get the document directory path
    final appDir = await pathProvider.getApplicationDocumentsDirectory();
    final localPath = path.join(appDir.path, imageName);

    // downloading
    final imageFile = File(localPath);
    await imageFile.writeAsBytes(response.bodyBytes);
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          
          child: Stack(
            children: <Widget>[
              FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 0.82,

                child: Image.network(
                  imageSrc,
                  fit: BoxFit.cover,
                )
              ),
              Positioned(
                top: 30,
                left: 20,

                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },

                  child: Container(
                    width: 33,
                    height: 33,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100)),
                    
                    child: Icon(Icons.arrow_back, color: Color(0xff808080)),
                  )
                ),
              ),
              ImageInfo(author: author, callback: downloadImage),
            ] 
          ),
        )
      )
    );
  }
}

class ImageInfo extends StatelessWidget {
  final User author;
  final dynamic Function() callback; 

  ImageInfo({@required this.author, @required this.callback});

  @override
  Widget build(BuildContext context) {  
    return Positioned(
      bottom: 0,

      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 180,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40,)
          ),
          color: Colors.white,
        ),

        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    author.profileImage,
                    width: 65,
                    height: 65,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 255,
                  margin: EdgeInsets.only(left: 25),

                  child: Text(
                    author.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff323232)),
                  ),
                ),
              ]
            ),
            SizedBox(height: 23),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 74,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          child: Icon(Icons.favorite, color: Color(0xffdcdcdc), size: 32),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          child: Icon(Icons.add_circle, color: Color(0xffdcdcdc), size: 32),
                        ),
                      ),
                    ]
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    callback();
                  },

                  child: Container(
                    child: Icon(Icons.download_rounded, color: Color(0xffdcdcdc), size: 32),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}