import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';

class BookView extends StatelessWidget {
  final bool isHomePage;
  final bool is3xGrid;

  BookView({this.isHomePage = true, this.is3xGrid = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MARGIN_MEDIUM_3),
      width: (!is3xGrid) ? 160 : 120,
      // color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: (!is3xGrid) ? 210 : 170,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                    image: DecorationImage(
                      image: NetworkImage(
                        (isHomePage) ?
                        "https://images-na.ssl-images-amazon.com/images/I/41LWgFsaBCL._SX329_BO1,204,203,200_.jpg"
                        :  "https://images-na.ssl-images-amazon.com/images/I/412llgHC2TL._SX329_BO1,204,203,200_.jpg",
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
                    child: Icon(
                      (!is3xGrid) ? Icons.more_horiz_rounded : Icons.more_vert_rounded,
                      color: PRIMARY_COLOR,
                    ),
                  ),
                ),
                Visibility(
                  visible: (isHomePage) ? false : true,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: MARGIN_MEDIUM,
                        left: MARGIN_CARD_MEDIUM_2,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: MARGIN_SMALL,
                          horizontal: MARGIN_CARD_MEDIUM_2,
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                          borderRadius: BorderRadius.circular(MARGIN_SMALL),
                        ),
                        child: Text(
                          "Sample",
                          style: TextStyle(
                            color: PRIMARY_COLOR,
                            fontSize: (!is3xGrid) ? MARGIN_CARD_MEDIUM_2 : MARGIN_MEDIUM,
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
                      padding: const EdgeInsets.only(
                        bottom: MARGIN_MEDIUM,
                        right: MARGIN_CARD_MEDIUM_2,
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
                          size: (!is3xGrid) ? MARGIN_MEDIUM_3 : MARGIN_MEDIUM_2,
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
            "Lean UX: Applying ...",
            style: TextStyle(
              color: Color.fromRGBO(94, 99, 103, 1.0),
            ),
          ),
          SizedBox(height: MARGIN_SMALL),
          Text(
            "Jeff Gothelf",
            style: TextStyle(
              color: Color.fromRGBO(94, 99, 103, 1.0),
            ),
          ),
        ],
      ),
    );
  }
}
