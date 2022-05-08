import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/horizontal_book_list_item_vo.dart';

abstract class BookModel {
  /// Network
  Future<List<HorizontalBookListItemVO>?> getHorizontalBookListItems(String publishedDate);
  void getMoreBookListByCategory(String listName, String offset);

  /// Database
  Stream<BookVO?> getBookDetailFromDatabase(String title);
  Stream<List<BookVO>?> getBookListForCarouselFromDatabase();
  Stream<List<BookVO>?> getMoreBookListByCategoryFromDatabase(String listName, String offset);
}