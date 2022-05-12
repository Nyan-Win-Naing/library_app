import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_app/pages/each_shelf_page.dart';
import 'package:library_app/pages/home_page.dart';
import 'package:library_app/pages/library_page.dart';
import 'package:library_app/pages/search_book_page.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/resources/strings.dart';

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
    print("Bottom nav index is: $bottomNavIndex");
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          toolbarHeight: 80,
          backgroundColor: PRIMARY_COLOR,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
            child: SearchFieldForAppBar(avatarRadius: avatarRadius),
          ),
          elevation: 0,
        ),
      ),
      body: (bottomNavIndex == 0) ? HomePage() : LibraryPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: MAIN_SCREEN_BOTTOM_NAVIGATION_HOME,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined),
            label: MAIN_SCREEN_BOTTOM_NAVIGATION_LIBRARY,
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
      padding: const EdgeInsets.only(
        left: MARGIN_CARD_MEDIUM_2,
        right: MARGIN_MEDIUM,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
        boxShadow: const [
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchBookPage(),
                ),
              );
            },
            child: Row(
              children: [
                const Icon(
                  Icons.search,
                  color: MAIN_SCREEN_APP_BAR_SEARCH_ICON_COLOR,
                ),
                const SizedBox(
                  width: MARGIN_CARD_MEDIUM_2,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 1.7 / 3,
                  child: const Text(
                    MAIN_SCREEN_APP_BAR_TEXT,
                    style: TextStyle(
                      color: MAIN_SCREEN_APP_BAR_TEXT_COLOR,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: MARGIN_MEDIUM_3),
          CircleAvatar(
            radius: avatarRadius,
            backgroundImage: const NetworkImage(
              "https://tasteminty.com/page/wp-content/uploads/2020/02/Girl-in-chair-.png",
            ),
          ),
        ],
      ),
    );
  }
}
