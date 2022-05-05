import 'package:flutter/material.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/viewitems/icon_chip_view.dart';
import 'package:library_app/viewitems/text_chip_view.dart';

class CategoryChipsSectionView extends StatelessWidget {
  CategoryChipsSectionView({
    Key? key,
    required this.chipNames,
    required this.runtimeType,
    this.isSearchBookResultPage = false,
  }) : super(key: key);

  final List chipNames;
  final Type runtimeType;
  bool isSearchBookResultPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView.builder(
        padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
        scrollDirection: Axis.horizontal,
        itemCount: chipNames.length,
        itemBuilder: (context, index) {
          return ((chipNames[index]).runtimeType.toString() == "IconData")
              ? Padding(
            padding: const EdgeInsets.only(right: MARGIN_MEDIUM),
            child: IconChipView(iconData: chipNames[index], isSearchBookResultPage: isSearchBookResultPage),
          )
              : Padding(
            padding: const EdgeInsets.only(right: MARGIN_MEDIUM),
            child: TextChipView(chipText: chipNames[index], isSearchBookResultPage: isSearchBookResultPage,),
          );
        },
      ),
    );
  }
}