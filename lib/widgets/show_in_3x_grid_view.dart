import 'package:flutter/material.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/viewitems/book_view.dart';

class ShowIn3xGridView extends StatelessWidget {
  final Function(String) onTap;
  final List<BookVO> books;

  ShowIn3xGridView({required this.onTap, required this.books});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: Key("3xgridView"),
      padding: EdgeInsets.only(left: MARGIN_MEDIUM_3, right: 10),
      itemCount: books.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 120 / 270,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: BookView(
            book: books[index],
            isHomePage: false,
            is3xGrid: true,
            onTap: (title) {
              onTap(title);
            },
          ),
        );
      },
    );
  }
}