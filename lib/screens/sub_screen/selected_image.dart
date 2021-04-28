import 'package:flutter/material.dart';

import 'package:unsplash_mobile/model/photo.dart';
import 'package:unsplash_mobile/screens/sub_screen/user_profile.dart';

class SelectedImage extends StatelessWidget {
  final User author;
  final String imageSrc;

  SelectedImage({@required this.author, @required this.imageSrc});

  downloadImage() async {}

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
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => UserProfile(user: author),
                ));
              },

              child: Row(
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
              )
            ),
            SizedBox(height: 23),
            Row(
              children: <Widget>[
                GestureDetector(
                  child: Icon(Icons.download_rounded, color: Color(0xffdcdcdc), size: 32,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}