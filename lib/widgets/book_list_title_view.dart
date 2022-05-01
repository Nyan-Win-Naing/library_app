import 'package:flutter/material.dart';
import 'package:library_app/resources/dimens.dart';

class BookListTitleView extends StatelessWidget {

  final String title;

  BookListTitleView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: MARGIN_MEDIUM_2 - 1,
            fontWeight: FontWeight.w600,
          ),
        ),

        Icon(
          Icons.arrow_forward_ios,
          color: Color.fromRGBO(2, 121, 202, 1.0),
          size: MARGIN_MEDIUM_3,
        ),
      ],
    );
  }
}
