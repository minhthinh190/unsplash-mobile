import 'package:flutter/material.dart';

Widget trendingTopics({List<String> items, Function(String) callback, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),

    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            topicBox(title: items[0], callback: callback),
            topicBox(title: items[1], callback: callback),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            topicBox(title: items[2], callback: callback),
            topicBox(title: items[3], callback: callback),
          ],
        ),
      ],
    )
  );
}

Widget topicBox({String title, Function(String) callback, context}) {
  return GestureDetector(
    onTap: () {
      callback(title);
    },
    
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
      alignment: Alignment.center,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Color(0xffececec),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff808080)),
      ),
    )
  );
}