import 'package:flutter/material.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/viewitems/book_view.dart';
import 'package:library_app/viewitems/icon_chip_view.dart';
import 'package:library_app/viewitems/text_chip_view.dart';
import 'package:library_app/viewitems/your_book_item_view.dart';
import 'package:library_app/widgets/category_chips_section_view.dart';
import 'package:library_app/widgets/show_in_2x_grid_view.dart';
import 'package:library_app/widgets/show_in_3x_grid_view.dart';

class ChipsAndBookListView extends StatelessWidget {
  const ChipsAndBookListView({
    Key? key,
    required this.chipNames,
    required this.runtimeType,
  }) : super(key: key);

  final List chipNames;
  final Type runtimeType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryChipsSectionView(
            chipNames: chipNames, runtimeType: runtimeType),
        SizedBox(height: MARGIN_MEDIUM_3),
        Padding(
          padding: EdgeInsets.only(left: 0),
          child: YourBookListSectionView(),
        ),
      ],
    );
  }
}

class YourBookListSectionView extends StatefulWidget {
  @override
  State<YourBookListSectionView> createState() =>
      _YourBookListSectionViewState();
}

class _YourBookListSectionViewState extends State<YourBookListSectionView> {
  IconData changeToView = Icons.grid_view;

  int val = 2;
  String sortByStatus = "Recent";

  @override
  Widget build(BuildContext context) {
    print("Set State works....");
    if (val == 1) {
      sortByStatus = "Author";
    } else if (val == 2) {
      sortByStatus = "Recent";
    } else {
      sortByStatus = "Title";
    }
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            right: MARGIN_MEDIUM_3,
            // left: (changeToView != Icons.view_list_outlined)
            //     ? MARGIN_MEDIUM_3
            //     : MARGIN_MEDIUM + 2,
            left: MARGIN_MEDIUM_3,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  showRadioBottomSheet();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.sort,
                      color: SECONDARY_COLOR,
                    ),
                    SizedBox(width: MARGIN_MEDIUM),
                    Text(
                      "Sort by: $sortByStatus",
                      style: TextStyle(
                        color: SECONDARY_COLOR,
                        fontSize: MARGIN_CARD_MEDIUM_2 + 1,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (changeToView == Icons.grid_view) {
                      // print("First work");
                      changeToView = Icons.grid_on;
                    } else if (changeToView == Icons.grid_on) {
                      // print("Second work");
                      changeToView = Icons.view_list_outlined;
                    } else {
                      // print("Third work");
                      changeToView = Icons.grid_view;
                    }
                  });
                },
                child: Icon(
                  changeToView,
                  color: SECONDARY_COLOR,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MARGIN_XLARGE),
        Builder(builder: (context) {
          if (changeToView == Icons.grid_view) {
            return ShowInVerticalListView(onTap: () => _navigateToBookDetailPage(context));
          } else if (changeToView == Icons.grid_on) {
            return ShowIn2xGridView(onTap: () => _navigateToBookDetailPage(context));
          } else {
            return ShowIn3xGridView(
              onTap: () {
                _navigateToBookDetailPage(context);
              },
            );
          }
        }),
      ],
    );
  }

  void _navigateToBookDetailPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailPage(),
      ),
    );
  }

  void showRadioBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MARGIN_LARGE, vertical: MARGIN_LARGE),
                  child: Text(
                    "Sort by",
                    style: TextStyle(
                        fontSize: MARGIN_MEDIUM_3, fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  height: 1,
                  color: Color.fromRGBO(219, 220, 222, 1.0),
                ),
                Column(
                  children: <Widget>[
                    ListTile(
                      title: Transform.translate(
                        offset: Offset(-12, 0),
                        child: Text(
                          "Author",
                          style: TextStyle(
                            fontSize: MARGIN_CARD_MEDIUM_2 + 2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      leading: Radio<int>(
                        value: 1,
                        groupValue: val,
                        onChanged: (value) {
                          setState(() {});
                          this.setState(() {
                            val = value ?? 0;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Transform.translate(
                        offset: Offset(-12, 0),
                        child: Text(
                          "Recent",
                          style: TextStyle(
                            fontSize: MARGIN_CARD_MEDIUM_2 + 2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      leading: Radio<int>(
                        value: 2,
                        groupValue: val,
                        onChanged: (value) {
                          setState(() {});
                          this.setState(() {
                            val = value ?? 0;
                          });
                        },
                        activeColor: Colors.blue,
                      ),
                    ),
                    ListTile(
                      title: Transform.translate(
                        offset: Offset(-12, 0),
                        child: Text(
                          "Title",
                          style: TextStyle(
                            fontSize: MARGIN_CARD_MEDIUM_2 + 2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      leading: Radio<int>(
                        value: 3,
                        groupValue: val,
                        onChanged: (value) {
                          setState(() {});
                          this.setState(() {
                            val = value ?? 0;
                          });
                        },
                        activeColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class ShowInVerticalListView extends StatelessWidget {

  final Function onTap;

  ShowInVerticalListView({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
      itemCount: 20,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return YourBookItemView(
          onTap: () {
            onTap();
          },
        );
      },
    );
  }
}
