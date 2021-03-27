import 'package:flutter/material.dart';

Widget categoryList({List<String> items, context}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    padding: EdgeInsets.symmetric(horizontal: 30),
    height: 50,

    child: ListView.builder(
      itemCount: items.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return CategoriesTile(title: items[index]);
      },
    ),
  );
}

class CategoriesTile extends StatelessWidget {
  final String title;
  CategoriesTile({@required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 30),
        alignment: Alignment.center,
       
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xff323232),
          ),
        ),
      ),
    );
  }
}