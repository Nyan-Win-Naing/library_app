import 'package:flutter/material.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/viewitems/book_view.dart';

class ShowIn2xGridView extends StatelessWidget {
  final Function(String) onTap;
  final bool isHomePage;

  final List<BookVO> bookList;

  ShowIn2xGridView({required this.onTap, this.isHomePage = false, required this.bookList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(left: MARGIN_MEDIUM_3),
      itemCount: bookList.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 160 / 275,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: BookView(
            book: bookList[index],
            isHomePage: isHomePage,
            onTap: (title) {
              onTap(title);
            },
          ),
        );
      },
    );
  }
}
