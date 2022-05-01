import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';

class BookView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MARGIN_MEDIUM_3),
      width: 160,
      // color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 210,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://images-na.ssl-images-amazon.com/images/I/41LWgFsaBCL._SX329_BO1,204,203,200_.jpg",
                      ),
                      fit: BoxFit.fill,
                    ),
                    boxShadow: [
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
                    padding: EdgeInsets.only(
                        top: MARGIN_MEDIUM, right: MARGIN_MEDIUM),
                    child: Icon(
                      Icons.more_horiz_rounded,
                      color: PRIMARY_COLOR,
                    ),
                  ),
                )
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
