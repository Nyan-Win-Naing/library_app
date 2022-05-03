import 'package:flutter/material.dart';
import 'package:library_app/pages/each_shelf_page.dart';
import 'package:library_app/pages/library_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LibraryApp(),
      // home: EachShelfPage(),
    );
  }
}

