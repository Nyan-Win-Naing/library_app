import 'package:flutter/material.dart';
import 'package:library_app/blocs/search_book_bloc.dart';
import 'package:library_app/data/models/book_model.dart';
import 'package:library_app/data/models/book_model_impl.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/dummy/dummy_book_list.dart';
import 'package:library_app/dummy/dummy_book_vo.dart';
import 'package:library_app/pages/search_books_result_page.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/debouncer.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/resources/strings.dart';
import 'package:library_app/viewitems/suggestion_book_item_view.dart';
import 'package:provider/provider.dart';

class SearchBookPage extends StatelessWidget {
  String input = "";

  List<DummyBookVO> suggestionBooksList = [];

  @override
  Widget build(BuildContext context) {
    // suggestionBooksList = [];
    print("Suggestion Book List: $suggestionBooksList");
    return ChangeNotifierProvider(
      create: (context) => SearchBookBloc(),
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
                key: Key("searchBookPageBack"),
              ),
            ),
          ),
          title: Selector<SearchBookBloc, List<BookVO>>(
            selector: (context, bloc) => bloc.searchResults ?? [],
            builder: (context, searchedResults, child) =>
                Builder(
                    builder: (context) {
                      SearchBookBloc bloc = Provider.of<SearchBookBloc>(context, listen: false);
                      return TextField(
                        key: Key("searchField"),
                        onChanged: (text) {
                          // onTextChange(text);
                          // setState(() {
                          //   input = text;
                          // });
                          bloc.onTextChange(text);
                        },
                        autofocus: true,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchBooksResultPage(
                                suggestionBooksList: searchedResults,
                                searchedWord: value,
                              ),
                            ),
                          );
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: MAIN_SCREEN_APP_BAR_TEXT,
                          hintStyle: TextStyle(
                            color: MAIN_SCREEN_APP_BAR_TEXT_COLOR,
                            fontSize: 15,
                          ),
                        ),
                      );
                    }
                ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: MARGIN_MEDIUM_3),
              child: Icon(
                Icons.mic_outlined,
                color: SEARCH_BOOK_PAGE_APP_BAR_ICON_COLOR,
              ),
            )
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Selector<SearchBookBloc, List<BookVO>>(
                  selector: (context, bloc) => bloc.searchResults ?? [],
                  builder: (context, searchedResults, child) =>
                      BookSearchAndSuggestionPage(
                          suggestionBooksList: searchedResults),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class BookSearchAndSuggestionPage extends StatelessWidget {
  const BookSearchAndSuggestionPage({
    Key? key,
    required this.suggestionBooksList,
  }) : super(key: key);

  final List<BookVO> suggestionBooksList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: MARGIN_MEDIUM_2),
        Visibility(
          visible: (suggestionBooksList.length != 0) ? true : false,
          child: SuggestionBookList(suggestionBookList: suggestionBooksList),
        ),
        const DefaultSuggestionSectionView(),
      ],
    );
  }
}

class SuggestionBookList extends StatelessWidget {
  final List<BookVO> suggestionBookList;

  SuggestionBookList({required this.suggestionBookList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
      child: Container(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: suggestionBookList.length,
          itemBuilder: (context, index) {
            return SuggestionBookItemView(
              bookVo: suggestionBookList[index],
              bookList: suggestionBookList,
            );
          },
        ),
      ),
    );
  }
}

class DefaultSuggestionSectionView extends StatelessWidget {
  const DefaultSuggestionSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
      child: Column(
        children: [
          ListTileSearchBook(iconData: Icons.auto_graph, title: "Top selling"),
          ListTileSearchBook(
              iconData: Icons.new_releases_outlined, title: "New releases"),
          ListTileSearchBook(iconData: Icons.shop, title: "Bookshop"),
        ],
      ),
    );
  }
}

class ListTileSearchBook extends StatelessWidget {
  final IconData iconData;
  final String title;

  ListTileSearchBook({required this.iconData, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: MARGIN_SMALL),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 0),
        leading: Icon(
          iconData,
          color: ADD_SHELF_PAGE_BACK_ICON_COLOR,
        ),
        title: Transform.translate(
          offset: const Offset(-MARGIN_CARD_MEDIUM_2, 0),
          child: Text(
            title,
            style: const TextStyle(
              color: SEARCH_BOOK_PAGE_LIST_TITLE_TEXT_COLOR,
              fontSize: MARGIN_CARD_MEDIUM_2 + 2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
