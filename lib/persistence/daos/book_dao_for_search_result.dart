import 'package:hive/hive.dart';
import 'package:library_app/data/vos/book_list_for_hive_vo.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/persistence/hive_constants.dart';

class BookDaoForSearchResult {
  static final BookDaoForSearchResult _singleton =
      BookDaoForSearchResult._internal();

  factory BookDaoForSearchResult() {
    return _singleton;
  }

  BookDaoForSearchResult._internal();

  void saveBooks(BookListForHiveVO, String searchedWord) async {
    await getBookBox().put(searchedWord, BookListForHiveVO);
  }

  List<BookVO> getBooksBySearchedWord(String searchedWord) {
    return getBookBox().get(searchedWord)?.bookList ?? [];
  }

  Box<BookListForHiveVO> getBookBox() {
    return Hive.box<BookListForHiveVO>(BOX_NAME_BOOK_VO_FOR_SEARCH_RESULT);
  }

  /// Reactive Programming
  Stream<void> getBooksEventStream() {
    return getBookBox().watch();
  }

  Stream<List<BookVO>> getBooksBySearchedWordStream(String searchedWord) {
    return Stream.value(getBooksBySearchedWord(searchedWord));
  }

  List<BookVO> getBooksBySearchedWordForReactive(String searchedWord) {
    if (getBooksBySearchedWord(searchedWord) != null &&
        getBooksBySearchedWord(searchedWord).isNotEmpty) {
      return getBooksBySearchedWord(searchedWord);
    } else {
      return [];
    }
  }
}
