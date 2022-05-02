import 'package:flutter/material.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';

class CancelChipView extends StatelessWidget {

  final IconData iconData;

  CancelChipView({required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Chip(
      shape: CircleBorder(),
      side: BorderSide(
        color: Color.fromRGBO(219, 221, 224, 1.0),
        width: 1,
      ),
      backgroundColor: PRIMARY_COLOR,
      label: Icon(
        iconData,
        size: MARGIN_MEDIUM_3,
        color: Color.fromRGBO(94, 99, 103, 1.0),
      ),
    );
  }
}
