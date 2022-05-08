import 'package:flutter/cupertino.dart';
import 'package:library_app/data/models/book_model.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/horizontal_book_list_item_vo.dart';
import 'package:library_app/network/dataagents/book_data_agent.dart';
import 'package:library_app/network/dataagents/retrofit_data_agent_impl.dart';
import 'package:library_app/persistence/daos/book_dao.dart';
import 'package:library_app/persistence/daos/book_dao_for_carousel.dart';
import 'package:stream_transform/stream_transform.dart';

class BookModelImpl extends BookModel {
  static final BookModelImpl _singleton = BookModelImpl._internal();

  factory BookModelImpl() {
    return _singleton;
  }

  BookModelImpl._internal();

  /// Daos
  BookDao mBookDao = BookDao();
  BookDaoForCarousel mBookDaoForCarousel = BookDaoForCarousel();

  /// Data Agent
  BookDataAgent mDataAgent = RetrofitDataAgentImpl();

  /// Network
  @override
  Future<List<HorizontalBookListItemVO>?> getHorizontalBookListItems(
      String publishedDate) {
    return mDataAgent
        .getHorizontalBookListItems(publishedDate)
        .then((hBookLists) async {
      hBookLists?.forEach((hBookList) {
        mBookDao.saveBooks(hBookList.books ?? []);
      });
      return Future.value(hBookLists);
    });
  }

  @override
  void getMoreBookListByCategory(String listName, String offset) {
    mDataAgent.getMoreBooks(listName, offset)
        .then((bookListByCategory) {
          List<BookVO>? bookList = bookListByCategory?.map((book) {
            book.category = listName;
            return book;
          }).toList();
          mBookDao.saveBooks(bookList);
    });
  }


  /// Database
  @override
  Stream<BookVO?> getBookDetailFromDatabase(String title) {
    BookVO? book = mBookDao.getBookByTitle(title);
    book?.timestamp = DateTime.now().millisecondsSinceEpoch;
    mBookDaoForCarousel.saveSingleBook(book);
    return mBookDao
        .getAllBooksEventStream()
        .startWith(mBookDao.getBookByTitleStream(title))
        .map((event) => mBookDao.getBookByTitleForReactive(title));
  }

  @override
  Stream<List<BookVO>?> getBookListForCarouselFromDatabase() {
    return mBookDaoForCarousel
        .getAllBooksEventStream()
        .startWith(mBookDaoForCarousel.getAllBooksStream())
        .map((event) => mBookDaoForCarousel.getAllBooksForReactive());
  }

  @override
  Stream<List<BookVO>?> getMoreBookListByCategoryFromDatabase(String listName, String offset) {
    this.getMoreBookListByCategory(listName, offset);
    return mBookDao
        .getAllBooksEventStream()
        .startWith(mBookDao.getAllBooksByCategoryStream(listName))
        .map((event) => mBookDao.getAllBooksByCategoryForReactive(listName));
  }

}
