import 'package:flutter/material.dart';
import 'package:library_app/blocs/chips_and_book_list_bloc.dart';
import 'package:library_app/data/vos/chip_vo.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/viewitems/icon_chip_view.dart';
import 'package:library_app/viewitems/text_chip_view.dart';
import 'package:provider/provider.dart';

class CategoryChipsSectionView extends StatelessWidget {
  CategoryChipsSectionView({
    Key? key,
    required this.chipList,
    required this.runtimeType,
    this.isSearchBookResultPage = false,
  }) : super(key: key);

  final List<ChipVO> chipList;
  final Type runtimeType;
  bool isSearchBookResultPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView.builder(
        padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
        scrollDirection: Axis.horizontal,
        itemCount: chipList.length,
        itemBuilder: (context, index) {
          ChipsAndBookListBloc bloc =
          Provider.of<ChipsAndBookListBloc>(context, listen: false);
          return ((chipList[index].chipName).runtimeType.toString() == "IconData")
              ? Padding(
                  padding: const EdgeInsets.only(right: MARGIN_MEDIUM),
                  child: Builder(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {

                          bloc.onTapCloseButton();
                        },
                        child: IconChipView(
                            iconData: chipList[index].chipName,
                            isSearchBookResultPage: isSearchBookResultPage),
                      );
                    }
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: MARGIN_MEDIUM),
                  child: Builder(builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        // ChipsAndBookListBloc bloc =
                        //     Provider.of<ChipsAndBookListBloc>(context,
                        //         listen: false);
                        bloc.onSelectChip(index);
                      },
                      child: TextChipView(
                        chip: chipList[index],
                        isSearchBookResultPage: isSearchBookResultPage,
                      ),
                    );
                  }),
                );
        },
      ),
    );
  }
}
