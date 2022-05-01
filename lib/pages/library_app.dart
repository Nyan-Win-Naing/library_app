import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:library_app/pages/home_page.dart';
import 'package:library_app/pages/library_page.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';

class LibraryApp extends StatefulWidget {
  @override
  State<LibraryApp> createState() => _LibraryAppState();
}

class _LibraryAppState extends State<LibraryApp> {
  int bottomNavIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final avatarRadius = screenHeight / 45;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          toolbarHeight: 80,
          backgroundColor: PRIMARY_COLOR,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
            child: SearchFieldForAppBar(avatarRadius: avatarRadius),
          ),
          elevation: 0,
        ),
      ),
      // body: HomePage(),
      body: LibraryPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined),
            label: "Library",
          ),
        ],
        currentIndex: bottomNavIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class SearchFieldForAppBar extends StatelessWidget {
  const SearchFieldForAppBar({
    Key? key,
    required this.avatarRadius,
  }) : super(key: key);

  final double avatarRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.only(
        left: MARGIN_CARD_MEDIUM_2,
        right: MARGIN_MEDIUM,
      ),
      decoration: BoxDecoration(
        // color: Colors.blueAccent,
        color: Colors.white,
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.5),
            spreadRadius: 0.2,
            blurRadius: 0.5,
            offset: Offset(0, 0.7),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Color.fromRGBO(94, 99, 103, 1.0),
          ),
          SizedBox(
            width: MARGIN_CARD_MEDIUM_2,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 1.7 / 3,
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search Play Books",
                hintStyle: TextStyle(
                  color: Color.fromRGBO(95, 100, 104, 1.0),
                  fontSize: 15,
                ),
              ),
            ),
          ),
          SizedBox(width: MARGIN_MEDIUM_3),
          CircleAvatar(
            radius: avatarRadius,
            backgroundImage: NetworkImage(
              "https://tasteminty.com/page/wp-content/uploads/2020/02/Girl-in-chair-.png",
            ),
          ),
        ],
      ),
    );
  }
}
