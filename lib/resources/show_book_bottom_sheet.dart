import 'package:flutter/material.dart';
import 'package:library_app/pages/home_page.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';

void showBookBottomSheet(BuildContext context, {isHomePage = true}) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: MARGIN_MEDIUM_3,
                left: MARGIN_LARGE,
                right: MARGIN_LARGE),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(MARGIN_SMALL),
                    image: const DecorationImage(
                      image: NetworkImage(
                        "https://images-na.ssl-images-amazon.com/images/I/51P8miZZ6OL._SX316_BO1,204,203,200_.jpg",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(width: MARGIN_MEDIUM_3),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "A Brief History Of Time",
                      style: TextStyle(
                        fontSize: MARGIN_MEDIUM_2 + 2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: MARGIN_SMALL,
                    ),
                    Text(
                      "Stephen Hawking . eBook",
                      style: TextStyle(
                        color: Color.fromRGBO(97, 101, 104, 1.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: MARGIN_MEDIUM_2),
          Container(
            height: 1,
            color: Color.fromRGBO(219, 220, 222, 1.0),
          ),
          SizedBox(height: MARGIN_CARD_MEDIUM_2),
          Padding(
            padding: const EdgeInsets.only(
                left: MARGIN_LARGE, right: MARGIN_LARGE),
            child: Column(
              children: [
                ListTileForBottomSheet(
                    iconData: Icons.open_in_new, title: "Open series"),
                ListTileForBottomSheet(
                    iconData: Icons.remove_circle_outline,
                    title: "Remove download"),
                ListTileForBottomSheet(
                    iconData: Icons.delete_outline,
                    title: "Delete from library"),
                ListTileForBottomSheet(
                    iconData: Icons.add, title: "Add to shelf"),
                ListTileForBottomSheet(
                    iconData: Icons.book_outlined, title: "About this eBook"),
              ],
            ),
          ),
          SizedBox(height: MARGIN_CARD_MEDIUM_2),
          Visibility(
            visible: (isHomePage) ? true : false,
            child: Container(
              padding: const EdgeInsets.only(
                  left: MARGIN_LARGE, right: MARGIN_LARGE),
              width: double.infinity,
              child: FlatButton(
                onPressed: () {},
                color: Color.fromRGBO(0,121,202, 1.0),
                height: 40,
                child: Text(
                  "Buy SGD1",
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: MARGIN_CARD_MEDIUM_2),
        ],
      );
    },
  );
}