import 'package:flutter/material.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/viewitems/book_view.dart';

class ShowIn3xGridView extends StatelessWidget {
  final Function onTap;

  ShowIn3xGridView({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(left: MARGIN_MEDIUM_3, right: 10),
      itemCount: 20,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 120 / 240,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: BookView(
            isHomePage: false,
            is3xGrid: true,
            onTap: () {
              onTap();
            },
          ),
        );
      },
    );
  }
}