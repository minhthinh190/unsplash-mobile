import 'package:flutter/cupertino.dart';

class Photo {
  final String id;
  final String url;
  
  Photo({@required this.id, @required this.url});

  factory Photo.fromMap(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      url: json['urls']['small']
    );
  }
}