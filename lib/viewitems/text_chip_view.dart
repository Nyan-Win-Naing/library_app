import 'package:flutter/material.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';

class TextChipView extends StatelessWidget {

  final String chipText;
  bool isSearchBookResultPage;

  TextChipView({required this.chipText, this.isSearchBookResultPage = false});

  @override
  Widget build(BuildContext context) {
    return Chip(
      side: BorderSide(
        color: Color.fromRGBO(219, 221, 224, 1.0),
        width: 1,
      ),
      backgroundColor: PRIMARY_COLOR,
      label: Text(
        chipText,
        style: TextStyle(
          color: Color.fromRGBO(94,99,103, 1.0),
          fontSize: (!isSearchBookResultPage) ? MARGIN_CARD_MEDIUM_2 : MARGIN_MEDIUM_2 - 2,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
