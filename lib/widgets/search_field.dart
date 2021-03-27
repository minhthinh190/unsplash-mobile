import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) callback;

  SearchField({Key key, @required this.controller, @required this.callback}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffeceff1),
        borderRadius: BorderRadius.circular(30),
      ),

      padding: EdgeInsets.symmetric(horizontal: 24),
      margin: EdgeInsets.only(top: 20, right: 30, left: 30, bottom: 20),

      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: this.controller,
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              this.callback(this.controller.text);
            },
            child: Container(
              child: Icon(Icons.search_rounded),
            ),
          ),
        ],
      ),
    );
  }
}