import 'package:flutter/material.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:library_app/pages/each_shelf_page.dart';
import 'package:library_app/pages/library_app.dart';
import 'package:library_app/pages/more_books_page.dart';

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
    );
  }
}

