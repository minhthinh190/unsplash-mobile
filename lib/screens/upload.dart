import 'package:flutter/material.dart';

import 'package:unsplash_mobile/widgets/appbar.dart';
import 'package:unsplash_mobile/widgets/bottom_bar.dart';

class Upload extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: MyAppBar(),
      body: Center(
        child: Text('')
      ),
      bottomNavigationBar: BottomBar(selectedIndex: 2),
    );
  }
}