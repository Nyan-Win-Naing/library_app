import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:library_app/blocs/search_book_result_bloc.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/dummy/dummy_book_vo.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/viewitems/book_search_result_item_view.dart';
import 'package:library_app/widgets/book_list_title_view.dart';
import 'package:library_app/widgets/category_chips_section_view.dart';
import 'package:library_app/widgets/horizontal_book_list_view.dart';
import 'package:provider/provider.dart';

class SearchBooksResultPage extends StatelessWidget {
  final List<BookVO> suggestionBooksList;
  final String searchedWord;

  SearchBooksResultPage({required this.suggestionBooksList, required this.searchedWord});

  List<dynamic> chipNames = [
    Icons.filter_list_rounded,
    "Format",
    "Price",
    "Price drops",
    "Family share",
    "Age",
    "Rating",
    "Language",
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchBookResultBloc(suggestionBooksList),
      child: Scaffold(
        backgroundColor: PRIMARY_COLOR,
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          elevation: 0.5,
          leading: Padding(
            padding: const EdgeInsets.only(left: MARGIN_MEDIUM_3),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: SEARCH_BOOK_PAGE_APP_BAR_ICON_COLOR,
                key: Key("searchedResultPageBack"),
              ),
            ),
          ),
          title: Text(
            searchedWord,
            style: const TextStyle(
              color: Colors.black,
              fontSize: MARGIN_MEDIUM_3,
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: MARGIN_MEDIUM_3),
              child: Icon(
                Icons.search,
                color: SEARCH_BOOK_PAGE_APP_BAR_ICON_COLOR,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: MARGIN_MEDIUM_3),
              child: Icon(
                Icons.mic_outlined,
                color: SEARCH_BOOK_PAGE_APP_BAR_ICON_COLOR,
              ),
            ),
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: MARGIN_MEDIUM_2),
                // CategoryChipsSectionView(
                //   chipNames: chipNames,
                //   runtimeType: runtimeType,
                //   isSearchBookResultPage: true,
                // ),
                // const SizedBox(height: MARGIN_MEDIUM_2),
                // SearchBookResultsInListView(suggestionBooksList: widget.suggestionBooksList),

                Selector<SearchBookResultBloc, Map<String, List<BookVO>>>(
                  selector: (context, bloc) => bloc.bookMap ?? {},
                  builder: (context, bookMap, child) =>
                      Selector<SearchBookResultBloc, List<String>>(
                        selector: (context, bloc) => bloc.keyList ?? [],
                        builder: (context, keyList, child) =>
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: bookMap.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: MARGIN_MEDIUM_3),
                                      child: BookListTitleView(
                                        title: keyList[index],
                                        // onTap: () => navigateToMoreBooksPage(
                                        //     context, hBookLists?[index]),
                                        onTap: () {},
                                      ),
                                    ),
                                    const SizedBox(height: MARGIN_MEDIUM_2),
                                    HorizontalBookListView(
                                      hBooks: bookMap[keyList[index]],
                                      onTap: (title) {
                                        _navigateToBookDetailPage(context, title, bookMap[keyList[index]] ?? []);
                                      },
                                      isHomePage: false,
                                    ),
                                    const SizedBox(height: MARGIN_MEDIUM),
                                  ],
                                );
                              },
                            ),
                      ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToBookDetailPage(BuildContext context, String title, List<BookVO> bookList) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailPage(
          title: title,
          bookList: bookList,
        ),
      ),
    );
  }
}

class SearchBookResultsInListView extends StatelessWidget {
  const SearchBookResultsInListView({
    Key? key,
    required this.suggestionBooksList,
  }) : super(key: key);

  final List<DummyBookVO> suggestionBooksList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: suggestionBooksList.length,
      itemBuilder: (context, index) {
        return BookSearchResultItemView(book: suggestionBooksList[index]);
      },
    );
  }
}
