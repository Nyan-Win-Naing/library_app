import 'package:flutter/material.dart';
import 'package:library_app/resources/dimens.dart';

class BookView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MARGIN_MEDIUM_3),
      width: 160,
      color: Colors.blue,
      child: Column(
        children: [
          Container(
            height: 210,
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
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
