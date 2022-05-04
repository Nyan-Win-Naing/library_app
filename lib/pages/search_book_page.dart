import 'package:flutter/material.dart';
import 'package:library_app/dummy/dummy_book_list.dart';
import 'package:library_app/dummy/dummy_book_vo.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/debouncer.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/viewitems/suggestion_book_item_view.dart';

class SearchBookPage extends StatefulWidget {
  @override
  State<SearchBookPage> createState() => _SearchBookPageState();
}

class _SearchBookPageState extends State<SearchBookPage> {
  final debouncer = Debouncer(milliseconds: 0);
  String input = "";

  List<DummyBookVO> suggestionBooksList = [];

  @override
  Widget build(BuildContext context) {
    // suggestionBooksList = [];
    print("Suggestion Book List: $suggestionBooksList");
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
            child: Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(60, 64, 67, 1.0),
            ),
          ),
        ),
        title: TextField(
          onChanged: (text) {
            onTextChange(text);
            setState(() {
              input = text;
            });
          },
          autofocus: true,
          textInputAction: TextInputAction.done,
          onSubmitted: (value) {
            print("Submitted Value is: $value");
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search Play Books",
            hintStyle: TextStyle(
              color: Color.fromRGBO(95, 100, 104, 1.0),
              fontSize: 15,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: MARGIN_MEDIUM_3),
            child: Icon(
              Icons.mic_outlined,
              color: Color.fromRGBO(60, 64, 67, 1.0),
            ),
          )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MARGIN_MEDIUM_2),
              Visibility(
                visible: (suggestionBooksList.length != 0) ? true : false,
                child: SuggestionBookList(suggestionBookList: suggestionBooksList),
              ),
              DefaultSuggestionSectionView(),
            ],
          ),
        ),
      ),
    );
  }

  onTextChange(String searchWord) {
    debouncer.run(() {
      if (searchWord != "") {
        dummyBookList.forEach((book) {
          String lowerName = book.bookName.toLowerCase();
          if (lowerName.contains(searchWord)) {
            print(lowerName);
            if (!suggestionBooksList.contains(book)) {
              suggestionBooksList.add(book);
            }
          }
        });
      } else {
        print("Search word is empty");
        suggestionBooksList = [];
      }
    });
  }
}

class SuggestionBookList extends StatelessWidget {

  final List<DummyBookVO> suggestionBookList;

  SuggestionBookList({required this.suggestionBookList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
      child: Container(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: suggestionBookList.length,
          itemBuilder: (context, index) {
            return SuggestionBookItemView(bookVo: suggestionBookList[index],);
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
        contentPadding: EdgeInsets.only(left: 0),
        leading: Icon(
          iconData,
          color: Color.fromRGBO(2, 119, 198, 1.0),
        ),
        title: Transform.translate(
          offset: Offset(-MARGIN_CARD_MEDIUM_2, 0),
          child: Text(
            title,
            style: TextStyle(
              color: Color.fromRGBO(100, 101, 105, 1.0),
              fontSize: MARGIN_CARD_MEDIUM_2 + 2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
