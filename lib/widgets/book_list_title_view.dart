import 'package:flutter/material.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';

class BookListTitleView extends StatelessWidget {

  final String title;
  final Function onTap;

  BookListTitleView({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onTap();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: MARGIN_MEDIUM_2 - 1,
              fontWeight: FontWeight.w600,
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios,
            color: TAB_BAR_SELECTED_COLOR,
            size: MARGIN_MEDIUM_3,
          ),
        ],
      ),
    );
  }
}
