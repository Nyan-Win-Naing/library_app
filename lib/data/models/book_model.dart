import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/horizontal_book_list_item_vo.dart';
import 'package:library_app/data/vos/shelf_vo.dart';

abstract class BookModel {
  /// Network
  Future<List<HorizontalBookListItemVO>?> getHorizontalBookListItems(String publishedDate);
  Future<List<BookVO>?> getMoreBookListByCategory(String listName, String offset);
  void getSearchedBookResults(String searchedWord);
  void saveShelfToShelfBox(ShelfVO shelf);
  // Future<List<BookVO>?> getMoreBooksTest(String listName, String offset);

  /// Database
  Stream<BookVO?> getBookDetailFromDatabase(String title);
  Stream<List<BookVO>?> getBookListForCarouselFromDatabase();
  Stream<List<BookVO>?> getMoreBookListByCategoryFromDatabase(String listName, String offset);
  Stream<List<BookVO>?> getSearchedBookResultsFromDatabase(String searchWord);
  Stream<List<ShelfVO>> getShelvesFromDatabase();
}