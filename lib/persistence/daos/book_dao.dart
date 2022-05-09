import 'package:hive/hive.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/persistence/hive_constants.dart';

class BookDao {
  static final BookDao _singleton = BookDao._internal();

  factory BookDao() {
    return _singleton;
  }

  BookDao._internal();

  void saveBooks(List<BookVO>? books) async {
    books = books?.map((book) {
      BookVO bookVo;
      if (getBookBox().keys.contains(book.title ?? "")) {
        bookVo = getBookByTitle(book.title ?? "") ?? BookVO();
        book.bookImage = bookVo.bookImage;
      }
      return book;
    }).toList();

    Map<String, BookVO> bookMap = Map.fromIterable(
      books ?? [],
      key: (book) => book.title,
      value: (book) => book,
    );
    print("saved");
    await getBookBox().putAll(bookMap);
  }

  void saveSingleBook(BookVO? book) async {
    if (book != null) {
      await getBookBox().put(book.title ?? "", book);
    }
  }

  List<BookVO> getAllBooks() {
    return getBookBox().values.toList();
  }

  List<BookVO> getAllBooksByCategory(String listNameEncoded) {
    return getBookBox()
        .values
        .toList()
        .where((book) => (book.category ?? "") == listNameEncoded)
        .toList();
  }

  BookVO? getBookByTitle(String title) {
    return getBookBox().get(title);
  }

  Box<BookVO> getBookBox() {
    return Hive.box<BookVO>(BOX_NAME_BOOK_VO);
  }

  /// Reactive Programming
  Stream<void> getAllBooksEventStream() {
    return getBookBox().watch();
  }

  Stream<List<BookVO>> getAllBooksStream() {
    return Stream.value(getAllBooks());
  }

  Stream<List<BookVO>> getAllBooksByCategoryStream(String listNameEncoded) {
    return Stream.value(getAllBooksByCategory(listNameEncoded));
  }

  Stream<BookVO?> getBookByTitleStream(String title) {
    print("Tapped book is: ${getBookByTitle(title)}");
    return Stream.value(getBookByTitle(title));
  }

  /// New Functions
  List<BookVO> getAllBooksForReactive() {
    if (getAllBooks() != null && getAllBooks().isNotEmpty) {
      return getAllBooks();
    } else {
      return [];
    }
  }

  List<BookVO> getAllBooksByCategoryForReactive(String listNameEncoded) {
    if (getAllBooksByCategory(listNameEncoded) != null &&
        getAllBooksByCategory(listNameEncoded).isNotEmpty) {
      return getAllBooksByCategory(listNameEncoded);
    } else {
      return [];
    }
  }

  BookVO? getBookByTitleForReactive(String title) {
    if (getBookByTitle(title) != null) {
      return getBookByTitle(title);
    } else {
      return BookVO();
    }
  }
}
