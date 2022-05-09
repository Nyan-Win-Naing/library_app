import 'package:hive/hive.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/persistence/hive_constants.dart';

class BookDaoForCarousel {

  static final BookDaoForCarousel _singleton = BookDaoForCarousel._internal();

  factory BookDaoForCarousel() {
    return _singleton;
  }

  BookDaoForCarousel._internal();

  void saveSingleBook(BookVO? book) async {
    if(book != null) {
      await getBookBox().put(book.title ?? "", book);
    }
  }

  List<BookVO> getAllBooks() {
    List<BookVO> bookList = getBookBox().values.toList();
    bookList.sort((b, a) => (a.timestamp ?? 0).compareTo((b.timestamp ?? 0)));
    return bookList;
  }

  Box<BookVO> getBookBox() {
    return Hive.box<BookVO>(BOX_NAME_BOOK_VO_FOR_CAROUSEL);
  }

  /// Reactive Programming
  Stream<void> getAllBooksEventStream() {
    return getBookBox().watch();
  }

  Stream<List<BookVO>> getAllBooksStream() {
    return Stream.value(getAllBooks());
  }

  List<BookVO> getAllBooksForReactive() {
    if(getAllBooks() != null && getAllBooks().isNotEmpty) {
      return getAllBooks();
    } else {
      return [];
    }
  }
}