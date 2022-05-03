import 'package:flutter/material.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';
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
          child: Icon(
            Icons.keyboard_arrow_left_sharp,
            color: SECONDARY_COLOR,
            size: MARGIN_XXLARGE,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: MARGIN_MEDIUM_3),
            // child: Icon(
            //   Icons.more_horiz,
            //   color: SECONDARY_COLOR,
            // ),
            child: PopupMenuButton(
              icon: Icon(
                Icons.more_horiz,
                color: SECONDARY_COLOR,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text("Rename shelf"),
                  value: 1,
                ),
                PopupMenuItem(
                  child: Text("Delete shelf"),
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
                color: Color.fromRGBO(219, 220, 222, 1.0),
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
      children: [
        Text(
          "10 Interaction Design Books to Read",
          style: TextStyle(
              fontSize: MARGIN_LARGE, fontWeight: FontWeight.w600, height: 1.2),
        ),
        SizedBox(height: MARGIN_MEDIUM),
        Text(
          "3 books",
          style: TextStyle(
            color: Color.fromRGBO(113, 118, 121, 1.0),
            fontSize: MARGIN_MEDIUM_2,
          ),
        ),
      ],
    );
  }
}
