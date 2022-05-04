import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/resources/show_book_bottom_sheet.dart';

class YourBookItemView extends StatelessWidget {

  final Function onTap;

  YourBookItemView({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
      child: Container(
        height: 90,
        // color: Colors.black26,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                onTap();
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 2 / 3,
                // color: Colors.black26,
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(MARGIN_SMALL),
                        image: const DecorationImage(
                          image: NetworkImage(
                            "https://images-na.ssl-images-amazon.com/images/I/412llgHC2TL._SX329_BO1,204,203,200_.jpg",
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(width: MARGIN_MEDIUM_2),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "The Making of a Manager",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: MARGIN_SMALL + 3),
                          Text(
                            "Julie Zhou",
                            style: TextStyle(
                              color: Color.fromRGBO(123, 128, 131, 1.0),
                              fontSize: MARGIN_CARD_MEDIUM_2,
                            ),
                          ),
                          SizedBox(height: MARGIN_SMALL),
                          Text(
                            "Ebook . Sample",
                            style: TextStyle(
                              color: Color.fromRGBO(123, 128, 131, 1.0),
                              fontSize: MARGIN_CARD_MEDIUM_2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.download_done,
                  color: SECONDARY_COLOR,
                  size: MARGIN_MEDIUM_2,
                ),
                SizedBox(width: MARGIN_MEDIUM_3),
                GestureDetector(
                  onTap: () {
                    showBookBottomSheet(context, isHomePage: false);
                  },
                  child: Icon(
                    Icons.more_horiz,
                    color: SECONDARY_COLOR,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
