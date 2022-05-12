import 'package:flutter/material.dart';
import 'package:library_app/blocs/chips_and_book_list_bloc.dart';
import 'package:library_app/blocs/library_bloc.dart';
import 'package:library_app/data/models/book_model.dart';
import 'package:library_app/data/models/book_model_impl.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/pages/add_shelf_page.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/resources/strings.dart';
import 'package:library_app/viewitems/book_view.dart';
import 'package:library_app/viewitems/icon_chip_view.dart';
import 'package:library_app/viewitems/shelf_item.dart';
import 'package:library_app/viewitems/text_chip_view.dart';
import 'package:library_app/viewitems/your_book_item_view.dart';
import 'package:library_app/widgets/chips_and_book_list_view.dart';
import 'package:library_app/widgets/your_shelves_view.dart';
import 'package:provider/provider.dart';

class LibraryPage extends StatefulWidget {
  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  List<dynamic> chipNames = [
    Icons.close,
    "Ebooks",
    "Downloaded",
    "Not started",
    "In progress",
    "Stephen Hawking",
    "Molly Fitz",
  ];

  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LibraryBloc(),
      child: Container(
        color: PRIMARY_COLOR,
        child: SingleChildScrollView(
          child: Column(
            children: [
              DefaultTabController(
                length: 2,
                child: TabBar(
                  unselectedLabelColor: TAB_BAR_UNSELECTED_LABEL_COLOR,
                  labelColor: TAB_BAR_SELECTED_COLOR,
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 3.0,
                      color: TAB_BAR_SELECTED_COLOR,
                    ),
                    insets: EdgeInsets.symmetric(horizontal: MARGIN_XXLARGE),
                  ),
                  tabs: const [
                    Tab(
                      child: Text(
                        LIBRARY_PAGE_TAB_BAR_YOUR_BOOKS_TEXT,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        LIBRARY_PAGE_TAB_BAR_YOUR_SHELVES_TEXT,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                  onTap: (index) {
                    setState(() {
                      tabIndex = index;
                    });
                  },
                ),
              ),
              Container(
                height: 1,
                color: HORIZONTAL_DIVIDER_LINE_COLOR,
              ),
              const SizedBox(height: MARGIN_MEDIUM),
              (tabIndex == 0)
                  ? Selector<LibraryBloc, List<BookVO>>(
                      selector: (context, bloc) => bloc.books ?? [],
                      builder: (context, books, child) => ChipsAndBookListView(
                        chipNames: chipNames,
                        runtimeType: runtimeType,
                        books: books,
                      ),
                    )
                  : YourShelvesView(),
            ],
          ),
        ),
      ),
    );
  }
}
