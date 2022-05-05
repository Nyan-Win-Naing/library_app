import 'package:flutter/material.dart';
import 'package:library_app/dummy/dummy_book_vo.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';

class SuggestionBookItemView extends StatelessWidget {
  final DummyBookVO bookVo;

  SuggestionBookItemView({required this.bookVo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailPage(),
          ),
        );
      },
      child: Container(
        height: 80,
        // color: Colors.black26,
        margin: EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
        child: Row(
          children: [
            Image.network(
              bookVo.imageUrl,
              width: 50,
              height: 70,
              fit: BoxFit.fill,
            ),
            SizedBox(width: MARGIN_MEDIUM_2),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookVo.bookName,
                    style: TextStyle(
                      color: Color.fromRGBO(94, 98, 102, 1.0),
                      fontSize: MARGIN_MEDIUM_2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: MARGIN_MEDIUM),
                  Text(
                    "${bookVo.author} . ${bookVo.description}",
                    style: TextStyle(
                      color: BOOK_DETAILS_TEXT_LIGHT_COLOR,
                      fontSize: MARGIN_CARD_MEDIUM_2,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
