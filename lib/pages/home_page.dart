import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:library_app/blocs/home_bloc.dart';
import 'package:library_app/data/models/book_model.dart';
import 'package:library_app/data/models/book_model_impl.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/horizontal_book_list_item_vo.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:library_app/pages/more_books_page.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/resources/show_book_bottom_sheet.dart';
import 'package:library_app/resources/strings.dart';
import 'package:library_app/viewitems/book_view.dart';
import 'package:library_app/widgets/book_list_title_view.dart';
import 'package:library_app/widgets/horizontal_book_list_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child: Container(
        color: PRIMARY_COLOR,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Selector<HomeBloc, List<BookVO>>(
                selector: (context, bloc) => bloc.bookListForCarousel ?? [],
                builder: (context, bookListForCarousel, child) => Container(
                  child: (bookListForCarousel != null &&
                          (bookListForCarousel.isNotEmpty))
                      ? HomeCarouselSectionView(
                          screenHeight: screenHeight,
                          bookList: bookListForCarousel,
                        )
                      : Container(),
                ),
              ),
              Selector<HomeBloc, List<HorizontalBookListItemVO>>(
                selector: (context, bloc) => bloc.hBookLists ?? [],
                builder: (context, hBookLists, child) =>
                    BooksListSectionView(hBookLists: hBookLists),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BooksListSectionView extends StatefulWidget {
  final List<HorizontalBookListItemVO>? hBookLists;

  BooksListSectionView({required this.hBookLists});

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
            unselectedLabelColor: TAB_BAR_UNSELECTED_LABEL_COLOR,
            labelColor: TAB_BAR_SELECTED_COLOR,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 3.0,
                color: TAB_BAR_SELECTED_COLOR,
              ),
              insets: EdgeInsets.symmetric(horizontal: MARGIN_XXLARGE),
            ),
            tabs: const [
              Tab(
                child: Text(
                  HOME_PAGE_TAB_BAR_EBOOKS_TEXT,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  HOME_PAGE_TAB_BAR_AUDIOBOOKS_TEXT,
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
        const SizedBox(height: MARGIN_MEDIUM_3),
        (tabBarIndex == 0)
            ? BooksByCategoryView(
                hBookLists: widget.hBookLists,
                horizontalEbookListTitles: horizontalEbookListTitles,
                // onTap: (title) {
                //   _navigateToBookDetailPage(context, title);
                // },
              )
            : BooksByCategoryView(
                hBookLists: widget.hBookLists,
                horizontalEbookListTitles: horizontalAudioBookListTitles,
                // onTap: (title) {
                //   _navigateToBookDetailPage(context, title);
                // },
              ),
      ],
    );
  }

  // void _navigateToBookDetailPage(BuildContext context, String title, List<BookVO> bookList) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => BookDetailPage(
  //         title: title,
  //         bookList: bookList,
  //       ),
  //     ),
  //   );
  // }
}

class BooksByCategoryView extends StatelessWidget {
  const BooksByCategoryView({
    Key? key,
    required this.horizontalEbookListTitles,
    required this.hBookLists,
    // required this.onTap,
  }) : super(key: key);

  final List<String> horizontalEbookListTitles;
  final List<HorizontalBookListItemVO>? hBookLists;
  // final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return (hBookLists != null || (hBookLists?.isNotEmpty ?? false))
        ? Container(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: hBookLists?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: MARGIN_MEDIUM_3),
                      child: BookListTitleView(
                        title: hBookLists?[index].listName ?? "",
                        onTap: () => navigateToMoreBooksPage(
                            context, hBookLists?[index]),
                      ),
                    ),
                    const SizedBox(height: MARGIN_MEDIUM_2),
                    HorizontalBookListView(
                      hBooks: hBookLists?[index].books ?? [],
                      onTap: (title) {
                        _navigateToBookDetailPage(context, title, hBookLists?[index].books ?? []);
                      },
                    ),
                    const SizedBox(height: MARGIN_MEDIUM),
                  ],
                );
              },
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  void navigateToMoreBooksPage(
      BuildContext context, HorizontalBookListItemVO? hBookListItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoreBookPage(hBookListItem: hBookListItem),
      ),
    );
  }

  void _navigateToBookDetailPage(BuildContext context, String title, List<BookVO> bookList) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailPage(
          title: title,
          bookList: bookList,
        ),
      ),
    );
  }
}

class HomeCarouselSectionView extends StatelessWidget {
  const HomeCarouselSectionView({
    Key? key,
    required this.screenHeight,
    required this.bookList,
  }) : super(key: key);

  final double screenHeight;
  final List<BookVO>? bookList;

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
        items: bookList?.map((book) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: HOME_PAGE_CAROUSEL_ITEM_WIDTH,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                        image: DecorationImage(
                          image: NetworkImage(book.bookImage ??
                              "https://cdn.bookauthority.org/dist/images/book-cover-not-available.6b5a104fa66be4eec4fd16aebd34fe04.png"),
                          fit: BoxFit.cover,
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
                            showBookBottomSheet(context, book);
                          },
                          child: const Icon(
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
                          color: HOME_PAGE_CAROUSEL_ITEM_PLAY_LINE_COLOR,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: MARGIN_MEDIUM,
                          bottom: MARGIN_CARD_MEDIUM_2,
                        ),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color:
                                HOME_PAGE_CAROUSEL_ITEM_ICON_BACKGROUND_COLOR,
                            borderRadius: BorderRadius.circular(MARGIN_SMALL),
                          ),
                          child: const Icon(
                            Icons.headphones,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: MARGIN_MEDIUM,
                          bottom: MARGIN_CARD_MEDIUM_2,
                        ),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color:
                                HOME_PAGE_CAROUSEL_ITEM_ICON_BACKGROUND_COLOR,
                            borderRadius: BorderRadius.circular(MARGIN_SMALL),
                          ),
                          child: const Icon(
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

class ListTileForBottomSheet extends StatelessWidget {
  final IconData iconData;
  final String title;

  ListTileForBottomSheet({required this.iconData, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
      contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
      leading: Icon(
        iconData,
        size: MARGIN_LARGE,
        color: BOTTOM_SHEET_LIST_TILE_ICON_COLOR,
      ),
      title: Transform.translate(
        offset: const Offset(-16, 0),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: MARGIN_CARD_MEDIUM_2 + 2,
            fontWeight: FontWeight.w500,
            color: BOTTOM_SHEET_LIST_TILE_TEXT_COLOR,
          ),
        ),
      ),
    );
  }
}
