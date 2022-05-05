import 'package:flutter/material.dart';
import 'package:library_app/dummy/dummy_book_vo.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';

class BookSearchResultItemView extends StatelessWidget {
  final DummyBookVO book;

  BookSearchResultItemView({required this.book});

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
        height: 150,
        margin: EdgeInsets.only(bottom: MARGIN_XLARGE),
        // color: Colors.black26,
        child: Row(
          children: [
            BookCoverSectionView(book: book),
            SizedBox(width: MARGIN_MEDIUM_2),
            Flexible(
              child: SearchedBookInformationView(book: book),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchedBookInformationView extends StatelessWidget {
  final DummyBookVO book;

  SearchedBookInformationView({required this.book});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          book.bookName,
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM),
        Text(
          book.author,
          style: TextStyle(
            color: BOOK_DETAILS_TEXT_LIGHT_COLOR,
          ),
        ),
        SizedBox(height: MARGIN_SMALL),
        Row(
          children: [
            Text(
              "eBook 4.4",
              style: TextStyle(
                color: BOOK_DETAILS_TEXT_LIGHT_COLOR,
              ),
            ),
            SizedBox(width: MARGIN_SMALL),
            Icon(
              Icons.star,
              size: MARGIN_CARD_MEDIUM_2,
              color: BOOK_DETAILS_TEXT_LIGHT_COLOR,
            )
          ],
        ),
        SizedBox(height: MARGIN_SMALL),
        Text(
          "SGD 12.50",
          style: TextStyle(
            color: BOOK_DETAILS_TEXT_LIGHT_COLOR,
          ),
        ),
      ],
    );
  }
}

class BookCoverSectionView extends StatelessWidget {
  final DummyBookVO book;

  BookCoverSectionView({required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
        image: DecorationImage(
          image: NetworkImage(
            book.imageUrl,
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
