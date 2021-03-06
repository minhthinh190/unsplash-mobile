import 'package:flutter/material.dart';

class TopicList extends StatefulWidget {
  final List<String> items;
  final Function(String) callback;
  TopicList({@required this.items, @required this.callback});

  @override 
  _TopicListState createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> {
  int currentSelectedIndex;

  @override 
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 15),
      height: 33,

      child: ListView.builder(
        itemCount: widget.items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CategoriesTile(
            index: index,
            title: widget.items[index],
            isSelected: currentSelectedIndex == index, 
            onSelect: () {
              setState(() {
                currentSelectedIndex = index;
              });
            },
            callback: widget.callback,
          );
        },        
      ),
    );
  }
}

class CategoriesTile extends StatefulWidget {
  final int index;
  final String title;
  final bool isSelected;
  final VoidCallback onSelect;
  final Function(String) callback;

  CategoriesTile({
    @required this.index, 
    @required this.title, 
    @required this.isSelected,
    @required this.onSelect,
    @required this.callback,
  });
  
  @override 
  _CategoriesTileState createState() => _CategoriesTileState();
}

class _CategoriesTileState extends State<CategoriesTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelect();
        widget.callback(widget.title);
      },
      
      child: widget.isSelected ? 
      Container(
        margin: EdgeInsets.only(left: 30),
        alignment: Alignment.center,
        
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xff323232), width: 3.0),
          ),
        ),
       
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff323232),
          ),
        ),
      ) 
      :
      Container(
        margin: EdgeInsets.only(left: 30),
        alignment: Alignment.center,

        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff808080),
          ),
        ),
      ),
    );
  }
}