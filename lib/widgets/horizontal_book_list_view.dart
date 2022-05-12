import 'package:flutter/material.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/horizontal_book_list_item_vo.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/viewitems/book_view.dart';

class HorizontalBookListView extends StatelessWidget {
  final List<BookVO>? hBooks;
  final Function(String) onTap;
  final bool isHomePage;

  HorizontalBookListView({required this.onTap, required this.hBooks, this.isHomePage = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (isHomePage) ? 290 : 330,
      // color: Colors.black26,
      child: ListView.builder(
        padding: EdgeInsets.only(left: MARGIN_MEDIUM_3),
        scrollDirection: Axis.horizontal,
        itemCount: hBooks?.length ?? 0,
        itemBuilder: (context, index) {
          return BookView(
            book: hBooks?[index],
            onTap: (title) {
              this.onTap(title);
            },
          );
        },
      ),
    );
  }
}
