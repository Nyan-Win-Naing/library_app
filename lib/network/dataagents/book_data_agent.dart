import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/horizontal_book_list_item_vo.dart';

abstract class BookDataAgent {
  Future<List<HorizontalBookListItemVO>?> getHorizontalBookListItems(String publishedDate);
  Future<List<BookVO>?> getMoreBooks(String listName, String offset);
}