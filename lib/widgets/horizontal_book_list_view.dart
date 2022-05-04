import 'package:flutter/material.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/viewitems/book_view.dart';

class HorizontalBookListView extends StatelessWidget {
  final Function onTap;

  HorizontalBookListView({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      // color: Colors.black26,
      child: ListView.builder(
        padding: EdgeInsets.only(left: MARGIN_MEDIUM_3),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return BookView(
            onTap: () {
              this.onTap();
            },
          );
        },
      ),
    );
  }
}
