import 'package:flutter/material.dart';

Widget searchField() {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xffeceff1),
      borderRadius: BorderRadius.circular(30),
    ),
    
    padding: EdgeInsets.symmetric(horizontal: 24),
    margin: EdgeInsets.only(top: 20, right: 30, left: 30, bottom: 10),

    child: Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              border: InputBorder.none,
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            child: Icon(Icons.search_rounded),
          ),
        ),
      ],
    ),
  );
}