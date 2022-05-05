import 'package:flutter/material.dart';
import 'package:library_app/pages/add_shelf_page.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/resources/strings.dart';
import 'package:library_app/viewitems/book_view.dart';
import 'package:library_app/viewitems/icon_chip_view.dart';
import 'package:library_app/viewitems/shelf_item.dart';
import 'package:library_app/viewitems/text_chip_view.dart';
import 'package:library_app/viewitems/your_book_item_view.dart';
import 'package:library_app/widgets/chips_and_book_list_view.dart';

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
                      LIBRARY_PAGE_TAB_BAR_YOUR_BOOKS_TEXT,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      LIBRARY_PAGE_TAB_BAR_YOUR_SHELVES_TEXT,
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
              color: HORIZONTAL_DIVIDER_LINE_COLOR,
            ),
            const SizedBox(height: MARGIN_MEDIUM),
            (tabIndex == 0)
                ? ChipsAndBookListView(chipNames: chipNames, runtimeType: runtimeType)
                : Container(
                    height: MediaQuery.of(context).size.height * 2.2 / 3,
                    child: Stack(
                      children: const [
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
      padding: const EdgeInsets.only(bottom: MARGIN_XLARGE),
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
            color: TAB_BAR_SELECTED_COLOR,
            borderRadius: BorderRadius.circular(MARGIN_LARGE),
            boxShadow: const [
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
              children: const [
                Icon(
                  Icons.create_outlined,
                  color: PRIMARY_COLOR,
                  size: MARGIN_MEDIUM_3,
                ),
                SizedBox(width: MARGIN_MEDIUM),
                Text(
                  YOUR_SHELVES_CREATE_NEW_BUTTON_TEXT,
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
      padding: const EdgeInsets.only(top: MARGIN_MEDIUM_3),
      itemCount: 2,
      // shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ShelfItem();
      },
    );
  }
}
