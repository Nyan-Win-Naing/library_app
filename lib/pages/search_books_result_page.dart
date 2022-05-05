import 'package:flutter/material.dart';
import 'package:library_app/dummy/dummy_book_vo.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/viewitems/book_search_result_item_view.dart';
import 'package:library_app/widgets/category_chips_section_view.dart';

class SearchBooksResultPage extends StatelessWidget {
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

  final List<DummyBookVO> suggestionBooksList;
  final String searchedWord;

  SearchBooksResultPage({required this.suggestionBooksList, required this.searchedWord});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              CategoryChipsSectionView(
                chipNames: chipNames,
                runtimeType: runtimeType,
                isSearchBookResultPage: true,
              ),
              const SizedBox(height: MARGIN_MEDIUM_2),
              SearchBookResultsInListView(suggestionBooksList: suggestionBooksList),
            ],
          ),
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
