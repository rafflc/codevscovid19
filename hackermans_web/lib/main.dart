import 'package:flutter/material.dart';
import 'package:hackermans_web/styles.dart';
import 'package:provider/provider.dart';


import 'data/dataModel.dart';

import 'element/searchList.dart';
import 'element/storeMap.dart';
import 'element/storedetail/storeDetail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<PageData>(
        create: (context) => PageData(),
        child: WebSite()
      ),
    );
  }
}


class WebSite extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          StoreMap(),
          PageElements(),
        ]
      ),
    );
  }
}

class PageElements extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Expanded(
          child: Row(
            children: <Widget>[
              SearchList(),
              StoreDetail()
            ],
          ),
        ),
      )
    );
  }

}