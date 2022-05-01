import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/viewitems/book_view.dart';
import 'package:library_app/widgets/book_list_title_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            HomeCarouselSectionView(screenHeight: screenHeight),
            BooksListSectionView(),
          ],
        ),
      ),
    );
  }
}

class BooksListSectionView extends StatelessWidget {
  const BooksListSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DefaultTabController(
          length: 2,
          child: TabBar(
            unselectedLabelColor: Color.fromRGBO(121, 122, 123, 1.0),
            labelColor: Color.fromRGBO(2, 121, 202, 1.0),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 3.0,
                color: Color.fromRGBO(2, 121, 202, 1.0),
              ),
              insets: EdgeInsets.symmetric(horizontal: MARGIN_XXLARGE),
            ),
            tabs: [
              Tab(
                child: Text(
                  "Ebooks",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Audiobooks",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM_3),
        Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
                    child: BookListTitleView(
                        title: "More Like Don't Make Me Think, Revisit..."),
                  ),
                  SizedBox(height: MARGIN_MEDIUM_2),
                  Container(
                    height: 290,
                    color: Colors.black26,
                    child: ListView.builder(
                      padding: EdgeInsets.only(left: MARGIN_MEDIUM_3),
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return BookView();
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class HomeCarouselSectionView extends StatelessWidget {
  const HomeCarouselSectionView({
    Key? key,
    required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      height: screenHeight * 1.1 / 3,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200.0,
          viewportFraction: 0.6,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
        ),
        items: [1, 2, 3, 4, 5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: 200,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                        image: const DecorationImage(
                          image: NetworkImage(
                              'https://play-lh.googleusercontent.com/LaI7iXfir4nzquNFFw4N1_lWpMMsIqJ5f-bKPe3nGssvx4OBzm4s6NVf2eS3eLUhHogM1fMaK2csEQ=s400-rw'),
                          fit: BoxFit.fill,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                            spreadRadius: 0.5,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: MARGIN_MEDIUM,
                          top: MARGIN_MEDIUM,
                        ),
                        child: Icon(
                          Icons.more_horiz_rounded,
                          color: PRIMARY_COLOR,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: MARGIN_SMALL,
                          left: MARGIN_MEDIUM,
                          right: MARGIN_MEDIUM,
                        ),
                        child: Container(
                          height: 2,
                          color: Color.fromRGBO(60, 61, 61, 1.0),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: MARGIN_MEDIUM,
                          bottom: MARGIN_CARD_MEDIUM_2,
                        ),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.7),
                            borderRadius: BorderRadius.circular(MARGIN_SMALL),
                          ),
                          child: Icon(
                            Icons.headphones,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: MARGIN_MEDIUM,
                          bottom: MARGIN_CARD_MEDIUM_2,
                        ),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.7),
                            borderRadius: BorderRadius.circular(MARGIN_SMALL),
                          ),
                          child: Icon(
                            Icons.done,
                            color: Colors.white,
                            size: MARGIN_MEDIUM_3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
