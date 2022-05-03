import 'package:flutter/material.dart';
import 'package:library_app/pages/add_shelf_page.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/viewitems/book_view.dart';
import 'package:library_app/viewitems/cancel_chip_view.dart';
import 'package:library_app/viewitems/shelf_item.dart';
import 'package:library_app/viewitems/text_chip_view.dart';
import 'package:library_app/viewitems/your_book_item_view.dart';

class LibraryPage extends StatefulWidget {
  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  List<dynamic> chipNames = [
    Icons.close,
    "Ebooks",
    "Downloaded",
    "Not started",
    "In progress",
    "Stephen Hawking",
    "Molly Fitz",
  ];

  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      child: SingleChildScrollView(
        child: Column(
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
                      "Your books",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Your shelves",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
                onTap: (index) {
                  setState(() {
                    tabIndex = index;
                  });
                },
              ),
            ),
            Container(
              height: 1,
              color: Color.fromRGBO(219, 220, 222, 1.0),
            ),
            SizedBox(height: MARGIN_MEDIUM),
            (tabIndex == 0)
                ? Column(
                    children: [
                      BookCategoryChipSectionView(
                          chipNames: chipNames, runtimeType: runtimeType),
                      SizedBox(height: MARGIN_MEDIUM_3),
                      Padding(
                        padding: EdgeInsets.only(left: MARGIN_MEDIUM_3),
                        child: YourBookListSectionView(),
                      ),
                    ],
                  )
                : Container(
                    height: MediaQuery.of(context).size.height * 2.2 / 3,
                    child: Stack(
                      children: [
                        YourShelvesListSectionView(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: CreateShelfButtonSectionView(),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class CreateShelfButtonSectionView extends StatelessWidget {
  const CreateShelfButtonSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MARGIN_XLARGE),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddShelfPage(),
            ),
          );
        },
        child: Container(
          width: 130,
          height: 45,
          decoration: BoxDecoration(
            color: Color.fromRGBO(2, 121, 202, 1.0),
            borderRadius: BorderRadius.circular(MARGIN_LARGE),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 5),
              )
            ],
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.create_outlined,
                  color: PRIMARY_COLOR,
                  size: MARGIN_MEDIUM_3,
                ),
                SizedBox(width: MARGIN_MEDIUM),
                Text(
                  "Create New",
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: MARGIN_CARD_MEDIUM_2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class YourShelvesListSectionView extends StatelessWidget {
  const YourShelvesListSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: MARGIN_MEDIUM_3),
      itemCount: 2,
      // shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ShelfItem();
      },
    );
  }
}

class YourBookListSectionView extends StatefulWidget {
  @override
  State<YourBookListSectionView> createState() =>
      _YourBookListSectionViewState();
}

class _YourBookListSectionViewState extends State<YourBookListSectionView> {
  IconData changeToView = Icons.grid_view;

  int val = 2;
  String sortByStatus = "Recent";

  @override
  Widget build(BuildContext context) {
    print("Set State works....");
    if (val == 1) {
      sortByStatus = "Author";
    } else if (val == 2) {
      sortByStatus = "Recent";
    } else {
      sortByStatus = "Title";
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: MARGIN_MEDIUM_3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  showRadioBottomSheet();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.sort,
                      color: SECONDARY_COLOR,
                    ),
                    SizedBox(width: MARGIN_MEDIUM),
                    Text(
                      "Sort by: $sortByStatus",
                      style: TextStyle(
                        color: SECONDARY_COLOR,
                        fontSize: MARGIN_CARD_MEDIUM_2 + 1,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (changeToView == Icons.grid_view) {
                      // print("First work");
                      changeToView = Icons.grid_on;
                    } else if (changeToView == Icons.grid_on) {
                      // print("Second work");
                      changeToView = Icons.view_list_outlined;
                    } else {
                      // print("Third work");
                      changeToView = Icons.grid_view;
                    }
                  });
                },
                child: Icon(
                  changeToView,
                  color: SECONDARY_COLOR,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MARGIN_XLARGE),
        Builder(builder: (context) {
          if (changeToView == Icons.grid_view) {
            return ShowInVerticalListView();
          } else if (changeToView == Icons.grid_on) {
            return ShowIn2xGridView();
          } else {
            return ShowIn3xGridView();
          }
        }),
      ],
    );
  }

  void showRadioBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MARGIN_LARGE, vertical: MARGIN_LARGE),
                  child: Text(
                    "Sort by",
                    style: TextStyle(
                        fontSize: MARGIN_MEDIUM_3, fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  height: 1,
                  color: Color.fromRGBO(219, 220, 222, 1.0),
                ),
                Column(
                  children: <Widget>[
                    ListTile(
                      title: Transform.translate(
                        offset: Offset(-12, 0),
                        child: Text(
                          "Author",
                          style: TextStyle(
                            fontSize: MARGIN_CARD_MEDIUM_2 + 2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      leading: Radio<int>(
                        value: 1,
                        groupValue: val,
                        onChanged: (value) {
                          setState(() {});
                          this.setState(() {
                            val = value ?? 0;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Transform.translate(
                        offset: Offset(-12, 0),
                        child: Text(
                          "Recent",
                          style: TextStyle(
                            fontSize: MARGIN_CARD_MEDIUM_2 + 2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      leading: Radio<int>(
                        value: 2,
                        groupValue: val,
                        onChanged: (value) {
                          setState(() {});
                          this.setState(() {
                            val = value ?? 0;
                          });
                        },
                        activeColor: Colors.blue,
                      ),
                    ),
                    ListTile(
                      title: Transform.translate(
                        offset: Offset(-12, 0),
                        child: Text(
                          "Title",
                          style: TextStyle(
                            fontSize: MARGIN_CARD_MEDIUM_2 + 2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      leading: Radio<int>(
                        value: 3,
                        groupValue: val,
                        onChanged: (value) {
                          setState(() {});
                          this.setState(() {
                            val = value ?? 0;
                          });
                        },
                        activeColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class ShowIn3xGridView extends StatelessWidget {
  const ShowIn3xGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 20,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 120 / 270,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: BookView(
            isHomePage: false,
            is3xGrid: true,
          ),
        );
      },
    );
  }
}

class ShowIn2xGridView extends StatelessWidget {
  const ShowIn2xGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 20,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 160 / 290,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: BookView(isHomePage: false),
        );
      },
    );
  }
}

class ShowInVerticalListView extends StatelessWidget {
  const ShowInVerticalListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(right: MARGIN_MEDIUM_3),
      itemCount: 20,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return YourBookItemView();
      },
    );
  }
}

class BookCategoryChipSectionView extends StatelessWidget {
  const BookCategoryChipSectionView({
    Key? key,
    required this.chipNames,
    required this.runtimeType,
  }) : super(key: key);

  final List chipNames;
  final Type runtimeType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView.builder(
        padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
        scrollDirection: Axis.horizontal,
        itemCount: chipNames.length,
        itemBuilder: (context, index) {
          return ((chipNames[index]).runtimeType.toString() == "IconData")
              ? Padding(
                  padding: const EdgeInsets.only(right: MARGIN_MEDIUM),
                  child: CancelChipView(iconData: chipNames[index]),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: MARGIN_MEDIUM),
                  child: TextChipView(chipText: chipNames[index]),
                );
        },
      ),
    );
  }
}

class LibraryTabBarSectionView extends StatelessWidget {
  const LibraryTabBarSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
              "Your books",
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Your shelves",
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
        onTap: (index) {},
      ),
    );
  }
}
