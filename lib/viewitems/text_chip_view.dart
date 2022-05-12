import 'package:flutter/material.dart';
import 'package:library_app/data/vos/chip_vo.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';

class TextChipView extends StatelessWidget {
  final ChipVO? chip;
  bool isSearchBookResultPage;

  TextChipView({required this.chip, this.isSearchBookResultPage = false});

  @override
  Widget build(BuildContext context) {
    return Chip(
      side: (!(chip?.isSelected ?? false))
          ? BorderSide(
              color: Color.fromRGBO(219, 221, 224, 1.0),
              width: 1,
            )
          : null,
      backgroundColor: (!(chip?.isSelected ?? false))
          ? PRIMARY_COLOR
          : Color.fromRGBO(5, 101, 160, 1.0),
      label: Text(
        chip?.chipName,
        style: TextStyle(
          color: (!(chip?.isSelected ?? false))
              ? Color.fromRGBO(94, 99, 103, 1.0)
              : PRIMARY_COLOR,
          fontSize: (!isSearchBookResultPage)
              ? MARGIN_CARD_MEDIUM_2
              : MARGIN_MEDIUM_2 - 2,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
