import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/resources/show_book_bottom_sheet.dart';

class BookView extends StatelessWidget {
  final bool isHomePage;
  final bool is3xGrid;
  final Function(String) onTap;

  final BookVO? book;

  final String keyName;

  BookView({
    this.isHomePage = true,
    this.is3xGrid = false,
    this.keyName = "",
    required this.onTap,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(book?.title ?? ""),
      child: Container(
        key: Key(keyName),
        margin: EdgeInsets.only(
            right: (!is3xGrid) ? MARGIN_MEDIUM_3 : MARGIN_CARD_MEDIUM_2 - 2),
        width: (!is3xGrid) ? 160 : 120,
        // color: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: (!is3xGrid) ? 210 : 150,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                      image: DecorationImage(
                        image: NetworkImage(
                          book?.bookImage ??
                              "https://www.richardsalter.com/wp-content/uploads/2011/07/Cover-not-available.jpg",
                        ),
                        fit: BoxFit.fill,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          spreadRadius: 0.5,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: MARGIN_MEDIUM, right: MARGIN_MEDIUM),
                      child: GestureDetector(
                        onTap: () {
                          showBookBottomSheet(context, book, isHomePage: isHomePage);
                        },
                        child: Icon(
                          Icons.more_horiz_rounded,
                          color: PRIMARY_COLOR,
                          size: (!is3xGrid) ? MARGIN_LARGE : MARGIN_MEDIUM_2,
                          key: Key("${keyName}more"),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (isHomePage) ? false : true,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: MARGIN_MEDIUM,
                          left: (!is3xGrid)
                              ? MARGIN_CARD_MEDIUM_2
                              : MARGIN_MEDIUM,
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: MARGIN_SMALL,
                            horizontal: (!is3xGrid)
                                ? MARGIN_CARD_MEDIUM_2
                                : MARGIN_MEDIUM,
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.7),
                            borderRadius: BorderRadius.circular(MARGIN_SMALL),
                          ),
                          child: Text(
                            "Sample",
                            style: TextStyle(
                              color: PRIMARY_COLOR,
                              fontSize: (!is3xGrid)
                                  ? MARGIN_CARD_MEDIUM_2
                                  : MARGIN_MEDIUM + 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (isHomePage) ? false : true,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MARGIN_MEDIUM,
                          right: (!is3xGrid)
                              ? MARGIN_CARD_MEDIUM_2
                              : MARGIN_MEDIUM,
                        ),
                        child: Container(
                          width: (!is3xGrid) ? 30 : 20,
                          height: (!is3xGrid) ? 30 : 20,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.7),
                            borderRadius: BorderRadius.circular(MARGIN_SMALL),
                          ),
                          child: Icon(
                            Icons.download_done,
                            color: Colors.white,
                            size:
                                (!is3xGrid) ? MARGIN_MEDIUM_3 : MARGIN_MEDIUM_2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MARGIN_CARD_MEDIUM_2),
            Text(
              book?.title ?? "",
              style: TextStyle(
                color: Color.fromRGBO(94, 99, 103, 1.0),
                fontSize:
                    (!is3xGrid) ? MARGIN_MEDIUM_2 - 2 : MARGIN_CARD_MEDIUM_2,
              ),
            ),
            SizedBox(height: MARGIN_SMALL),
            Text(
              book?.author ?? "",
              style: TextStyle(
                color: Color.fromRGBO(94, 99, 103, 1.0),
                fontSize:
                    (!is3xGrid) ? MARGIN_MEDIUM_2 - 2 : MARGIN_CARD_MEDIUM_2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
