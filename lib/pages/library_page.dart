import 'package:flutter/material.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';

class LibraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      child: SingleChildScrollView(
        child: Column(
          children: [
            LibraryTabBarSectionView(),
            Container(
              height: 1,
              color: Color.fromRGBO(219, 220, 222, 1.0),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: MARGIN_CARD_MEDIUM_2,
                left: MARGIN_MEDIUM_2,
              ),
              child: Row(
                children: [
                  Chip(
                    shape: CircleBorder(),
                    side: BorderSide(
                      color: Color.fromRGBO(219, 221, 224, 1.0),
                      width: 1,
                    ),
                    backgroundColor: Colors.white,
                    label: Icon(
                      Icons.close,
                      size: MARGIN_MEDIUM_3,
                      color: Color.fromRGBO(94, 99, 103, 1.0),
                    ),
                  ),
                  SizedBox(width: MARGIN_MEDIUM),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LibraryTabBarSectionView extends StatelessWidget {
  const LibraryTabBarSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: TabBar(
        unselectedLabelColor: Color.fromRGBO(121, 122, 123, 1.0),
        labelColor: Color.fromRGBO(2, 121, 202, 1.0),
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 3.0,
            color: Color.fromRGBO(2, 121, 202, 1.0),
          ),
          insets: EdgeInsets.symmetric(horizontal: MARGIN_XXLARGE),
        ),
        tabs: const [
          Tab(
            child: Text(
              "Your books",
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Your shelves",
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
        onTap: (index) {},
      ),
    );
  }
}
