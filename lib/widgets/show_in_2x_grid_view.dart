import 'package:flutter/material.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/viewitems/book_view.dart';

class ShowIn2xGridView extends StatelessWidget {
  final Function onTap;
  final bool isHomePage;

  ShowIn2xGridView({required this.onTap, this.isHomePage = false});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(left: MARGIN_MEDIUM_3),
      itemCount: 20,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 160 / 270,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: BookView(
            isHomePage: isHomePage,
            onTap: () {
              onTap();
            },
          ),
        );
      },
    );
  }
}
