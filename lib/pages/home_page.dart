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
      color: PRIMARY_COLOR,
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

class BooksListSectionView extends StatefulWidget {
  BooksListSectionView({
    Key? key,
  }) : super(key: key);

  @override
  State<BooksListSectionView> createState() => _BooksListSectionViewState();
}

class _BooksListSectionViewState extends State<BooksListSectionView> {
  List<String> horizontalEbookListTitles = [
    "More Like Don't Make Me Think, Revisit...",
    "Ebooks for you",
    "On your wishlist"
  ];

  List<String> horizontalAudioBookListTitles = [
    "Audio Books",
    "Audio books for you",
    "On your wishlist audio books"
  ];

  int tabBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
          length: 2,
          child: TabBar(
            unselectedLabelColor: Color.fromRGBO(121, 122, 123, 1.0),
            labelColor: Color.fromRGBO(2, 121, 202, 1.0),
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 3.0,
                color: Color.fromRGBO(2, 121, 202, 1.0),
              ),
              insets: EdgeInsets.symmetric(horizontal: MARGIN_XXLARGE),
            ),
            tabs: const [
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
            onTap: (index) {
              setState(() {
                tabBarIndex = index;
              });
            },
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM_3),
        (tabBarIndex == 0)
            ? BooksByCategoryView(
                horizontalEbookListTitles: horizontalEbookListTitles)
            : BooksByCategoryView(
                horizontalEbookListTitles: horizontalAudioBookListTitles),
      ],
    );
  }
}

class BooksByCategoryView extends StatelessWidget {
  const BooksByCategoryView({
    Key? key,
    required this.horizontalEbookListTitles,
  }) : super(key: key);

  final List<String> horizontalEbookListTitles;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: horizontalEbookListTitles.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
                child:
                    BookListTitleView(title: horizontalEbookListTitles[index]),
              ),
              SizedBox(height: MARGIN_MEDIUM_2),
              HorizontalBookListView(),
              SizedBox(height: MARGIN_MEDIUM),
            ],
          );
        },
      ),
    );
  }
}

class HorizontalBookListView extends StatelessWidget {
  const HorizontalBookListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      // color: Colors.black26,
      child: ListView.builder(
        padding: EdgeInsets.only(left: MARGIN_MEDIUM_3),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return BookView();
        },
      ),
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
                        child: GestureDetector(
                          onTap: () {
                            showBottomSheet(context);
                          },
                          child: Icon(
                            Icons.more_horiz_rounded,
                            color: PRIMARY_COLOR,
                          ),
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

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: MARGIN_MEDIUM_3,
                  left: MARGIN_LARGE,
                  right: MARGIN_LARGE),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(MARGIN_SMALL),
                      image: const DecorationImage(
                        image: NetworkImage(
                          "https://images-na.ssl-images-amazon.com/images/I/51P8miZZ6OL._SX316_BO1,204,203,200_.jpg",
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(width: MARGIN_MEDIUM_3),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "A Brief History Of Time",
                        style: TextStyle(
                          fontSize: MARGIN_MEDIUM_2 + 2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: MARGIN_SMALL,
                      ),
                      Text(
                        "Stephen Hawking . eBook",
                        style: TextStyle(
                          color: Color.fromRGBO(97, 101, 104, 1.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: MARGIN_MEDIUM_2),
            Container(
              height: 1,
              color: Color.fromRGBO(219, 220, 222, 1.0),
            ),
            SizedBox(height: MARGIN_CARD_MEDIUM_2),
            Padding(
              padding: const EdgeInsets.only(
                  left: MARGIN_LARGE, right: MARGIN_LARGE),
              child: Column(
                children: [
                  ListTileForBottomSheet(
                      iconData: Icons.open_in_new, title: "Open series"),
                  ListTileForBottomSheet(
                      iconData: Icons.remove_circle_outline,
                      title: "Remove download"),
                  ListTileForBottomSheet(
                      iconData: Icons.delete_outline,
                      title: "Delete from library"),
                  ListTileForBottomSheet(
                      iconData: Icons.add, title: "Add to shelf"),
                  ListTileForBottomSheet(
                      iconData: Icons.book_outlined, title: "About this eBook"),
                ],
              ),
            ),
            SizedBox(height: MARGIN_CARD_MEDIUM_2),
            Container(
              padding: const EdgeInsets.only(
                  left: MARGIN_LARGE, right: MARGIN_LARGE),
              width: double.infinity,
              child: FlatButton(
                onPressed: () {},
                color: Color.fromRGBO(0,121,202, 1.0),
                height: 40,
                child: Text(
                  "Buy SGD1",
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: MARGIN_CARD_MEDIUM_2),
          ],
        );
      },
    );
  }
}

class ListTileForBottomSheet extends StatelessWidget {
  final IconData iconData;
  final String title;

  ListTileForBottomSheet({required this.iconData, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity(horizontal: 0, vertical: -1),
      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
      leading: Icon(iconData,
          size: MARGIN_LARGE, color: Color.fromRGBO(95, 98, 103, 1.0)),
      title: Transform.translate(
        offset: Offset(-16, 0),
        child: Text(
          title,
          style: TextStyle(
            fontSize: MARGIN_CARD_MEDIUM_2 + 2,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(70, 71, 73, 1.0),
          ),
        ),
      ),
    );
  }
}
