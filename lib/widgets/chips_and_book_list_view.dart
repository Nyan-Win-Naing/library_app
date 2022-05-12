import 'package:flutter/material.dart';
import 'package:library_app/blocs/chips_and_book_list_bloc.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/chip_vo.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/resources/strings.dart';
import 'package:library_app/viewitems/book_view.dart';
import 'package:library_app/viewitems/icon_chip_view.dart';
import 'package:library_app/viewitems/text_chip_view.dart';
import 'package:library_app/viewitems/your_book_item_view.dart';
import 'package:library_app/widgets/category_chips_section_view.dart';
import 'package:library_app/widgets/show_in_2x_grid_view.dart';
import 'package:library_app/widgets/show_in_3x_grid_view.dart';
import 'package:provider/provider.dart';

class ChipsAndBookListView extends StatelessWidget {

  ChipsAndBookListView({required this.chipNames,
      required this.runtimeType,
      required this.books}) {
    this.chipNames = chipNames;
    this.runtimeType = runtimeType;
    this.books = books;
  }

  List chipNames;
  Type runtimeType;
  List<BookVO> books;

  @override
  Widget build(BuildContext context) {
    print("Print books before add to chips and book list bloc: $books.......");
    return ChangeNotifierProvider(
      create: (context) => ChipsAndBookListBloc(),
      child: Column(
        children: [
          Selector<ChipsAndBookListBloc, List<ChipVO>>(
            selector: (context, bloc) => bloc.chips ?? [],
            shouldRebuild: (previous, next) => previous != next,
            builder: (context, chips, child) =>
                CategoryChipsSectionView(
                    chipList: chips, runtimeType: runtimeType),
          ),
          const SizedBox(height: MARGIN_MEDIUM_3),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: YourBookListSectionView(books: books),
          ),
        ],
      ),
    );
  }
}

class YourBookListSectionView extends StatefulWidget {
  final List<BookVO> books;

  YourBookListSectionView({required this.books});

  @override
  State<YourBookListSectionView> createState() =>
      _YourBookListSectionViewState();
}

class _YourBookListSectionViewState extends State<YourBookListSectionView> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: MARGIN_MEDIUM_3,
            left: MARGIN_MEDIUM_3,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Selector<ChipsAndBookListBloc, String>(
                selector: (context, bloc) => bloc.sortByStatus,
                builder: (context, sortByStatus, child) =>
                    Selector<ChipsAndBookListBloc, int>(
                  selector: (context, bloc) => bloc.radioVal,
                  builder: (context, radioVal, child) {
                    return GestureDetector(
                      onTap: () {
                        showRadioBottomSheet(radioVal);
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.sort,
                            color: SECONDARY_COLOR,
                          ),
                          SizedBox(width: MARGIN_MEDIUM),
                          Text(
                            "Sort by: $sortByStatus",
                            style: const TextStyle(
                              color: SECONDARY_COLOR,
                              fontSize: MARGIN_CARD_MEDIUM_2 + 1,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Selector<ChipsAndBookListBloc, IconData?>(
                selector: (context, bloc) => bloc.changeToView,
                builder: (context, changeToView, child) =>
                    GestureDetector(
                      onTap: () {
                        ChipsAndBookListBloc bloc =
                        Provider.of<ChipsAndBookListBloc>(context, listen: false);
                        bloc.onTapChangeView(changeToView);
                      },
                      child: Icon(
                        changeToView,
                        color: SECONDARY_COLOR,
                      ),
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: MARGIN_XLARGE),
        Selector<ChipsAndBookListBloc, List<BookVO>>(
          selector: (context, bloc) => bloc.books ?? [],
          shouldRebuild: (previous, next) => previous != next,
          builder: (context, books, child) =>
              Selector<ChipsAndBookListBloc, IconData?>(
                selector: (context, bloc) => bloc.changeToView,
                builder: (context, changeToView, Widget? child) =>
                    Builder(builder: (context) {
                      if (changeToView == Icons.grid_view) {
                        return ShowInVerticalListView(
                          onTap: () => _navigateToBookDetailPage(context, books),
                          books: books,
                        );
                      } else if (changeToView == Icons.grid_on) {
                        return ShowIn2xGridView(
                          onTap: (title) => _navigateToBookDetailPage(context, books),
                          bookList: books,
                        );
                      } else {
                        return ShowIn3xGridView(
                          onTap: (title) {
                            _navigateToBookDetailPage(context, books);
                          },
                          books: books,
                        );
                      }
                    }),
              ),
        ),
      ],
    );
  }

  void _navigateToBookDetailPage(BuildContext context, List<BookVO> bookList) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailPage(
          title: "",
          bookList: bookList,
        ),
      ),
    );
  }

  void showRadioBottomSheet(int radioVal) {
    ChipsAndBookListBloc bloc = Provider.of(context, listen: false);
    print("showRadioBottomSheet: $radioVal");
    showModalBottomSheet(
      context: context,
      builder: (context) {
        int radioValue = 2;
        return StatefulBuilder(
          builder: (BuildContext bctxt, StateSetter stateSetter) {
            return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MARGIN_LARGE, vertical: MARGIN_LARGE),
                    child: Text(
                      BOTTOM_SHEET_SORT_BY_TITLE,
                      style: TextStyle(
                          fontSize: MARGIN_MEDIUM_3,
                          fontWeight: FontWeight.w400),
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
                          child: const Text(
                            SORT_BY_BUTTOM_SHEET_AUTHOR,
                            style: TextStyle(
                              fontSize: MARGIN_CARD_MEDIUM_2 + 2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        leading: Radio<int>(
                          value: 1,
                          groupValue: bloc.radioVal,
                          onChanged: (value) {
                            stateSetter(() {});
                            bloc.onTapBottomSheetRadioButton(value);
                          },
                        ),
                      ),
                      ListTile(
                        title: Transform.translate(
                          offset: Offset(-12, 0),
                          child: const Text(
                            SORT_BY_BUTTOM_SHEET_RECENT,
                            style: TextStyle(
                              fontSize: MARGIN_CARD_MEDIUM_2 + 2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        leading: Radio<int>(
                          value: 2,
                          groupValue: bloc.radioVal,
                          onChanged: (value) {
                            stateSetter(() {
                            });
                            bloc.onTapBottomSheetRadioButton(value);

                          },
                          activeColor: Colors.blue,
                        ),
                      ),
                      ListTile(
                        title: Transform.translate(
                          offset: Offset(-12, 0),
                          child: const Text(
                            SORT_BY_BUTTOM_SHEET_TITLE,
                            style: TextStyle(
                              fontSize: MARGIN_CARD_MEDIUM_2 + 2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        leading: Radio<int>(
                          value: 3,
                          groupValue: bloc.radioVal,
                          onChanged: (value) {
                            stateSetter(() {
                            });
                            bloc.onTapBottomSheetRadioButton(value);
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
  final List<BookVO> books;

  ShowInVerticalListView({required this.onTap, required this.books});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
      itemCount: books.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return YourBookItemView(
          onTap: () {
            onTap();
          },
          book: books[index],
        );
      },
    );
  }
}
