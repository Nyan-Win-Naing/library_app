import 'package:flutter/material.dart';
import 'package:library_app/resources/dimens.dart';

class ShelfItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      // color: Colors.black26,
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
      child: Row(
        children: [
          Container(
            width: 70,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius:
              BorderRadius.circular(MARGIN_SMALL),
              image: DecorationImage(
                image: NetworkImage(
                  "https://images-na.ssl-images-amazon.com/images/I/410RTQezHYL._SX326_BO1,204,203,200_.jpg",
                ),
                fit: BoxFit.fill,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(5, 0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
