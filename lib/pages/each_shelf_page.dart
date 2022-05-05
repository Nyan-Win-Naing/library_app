import 'package:flutter/material.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/resources/strings.dart';
import 'package:library_app/widgets/chips_and_book_list_view.dart';

class EachShelfPage extends StatelessWidget {
  List<dynamic> chipNames = [
    Icons.close,
    "Ebooks",
    "Downloaded",
    "Not started",
    "In progress",
    "Stephen Hawking",
    "Molly Fitz",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: PRIMARY_COLOR,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.keyboard_arrow_left_sharp,
            color: SECONDARY_COLOR,
            size: MARGIN_XXLARGE,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: MARGIN_MEDIUM_3),
            child: PopupMenuButton(
              icon: const Icon(
                Icons.more_horiz,
                color: SECONDARY_COLOR,
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  child: Text(EACH_SHELF_PAGE_POP_UP_MENU_ITEM_1),
                  value: 1,
                ),
                const PopupMenuItem(
                  child: Text(EACH_SHELF_PAGE_POP_UP_MENU_ITEM_2),
                  value: 2,
                )
              ],
              onSelected: (index) {
                if(index == 2) {
                  Navigator.pop(context);
                }
              },
            ),
          )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: MARGIN_MEDIUM_3,
                  right: MARGIN_MEDIUM_3,
                  top: MARGIN_XXLARGE,
                  bottom: MARGIN_MEDIUM_2,
                ),
                child: BookShelfNameAndDescriptionSectionView(),
              ),
              const SizedBox(height: MARGIN_SMALL),
              Container(
                height: 1,
                color: HORIZONTAL_DIVIDER_LINE_COLOR,
              ),
              const SizedBox(height: MARGIN_MEDIUM),
              ChipsAndBookListView(
                  chipNames: chipNames, runtimeType: runtimeType),
            ],
          ),
        ),
      ),
    );
  }
}

class BookShelfNameAndDescriptionSectionView extends StatelessWidget {
  const BookShelfNameAndDescriptionSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "10 Interaction Design Books to Read",
          style: TextStyle(
              fontSize: MARGIN_LARGE, fontWeight: FontWeight.w600, height: 1.2),
        ),
        SizedBox(height: MARGIN_MEDIUM),
        Text(
          "3 books",
          style: TextStyle(
            color: EACH_SHELF_PAGE_BOOK_COUNT_TEXT_COLOR,
            fontSize: MARGIN_MEDIUM_2,
          ),
        ),
      ],
    );
  }
}
