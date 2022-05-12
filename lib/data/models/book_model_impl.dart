import 'package:flutter/cupertino.dart';
import 'package:library_app/data/models/book_model.dart';
import 'package:library_app/data/vos/book_list_for_hive_vo.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/horizontal_book_list_item_vo.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/network/dataagents/book_data_agent.dart';
import 'package:library_app/network/dataagents/retrofit_data_agent_impl.dart';
import 'package:library_app/persistence/daos/book_dao.dart';
import 'package:library_app/persistence/daos/book_dao_for_carousel.dart';
import 'package:library_app/persistence/daos/book_dao_for_search_result.dart';
import 'package:library_app/persistence/daos/shelf_dao.dart';
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
  BookDaoForSearchResult mBookDaoForSearchResult = BookDaoForSearchResult();
  ShelfDao mShelfDao = ShelfDao();

  /// Data Agent
  BookDataAgent mDataAgent = RetrofitDataAgentImpl();

  /// Network
  @override
  Future<List<HorizontalBookListItemVO>?> getHorizontalBookListItems(
      String publishedDate) {
    return mDataAgent
        .getHorizontalBookListItems(publishedDate)
        .then((hBookLists) async {
      // hBookLists?.forEach((hBookList) {
      //   mBookDao.saveBooks(hBookList.books ?? []);
      // });
      hBookLists?.forEach((hBookList) {
        List<BookVO> bList = hBookList.books?.map((book) {
              book.category = hBookList.listNameEncoded;
              return book;
            }).toList() ??
            [];
        mBookDao.saveBooks(bList);
      });
      return Future.value(hBookLists);
    });
  }

  @override
  Future<List<BookVO>?> getMoreBookListByCategory(String listName, String offset) {
    print("getMoreBookListByCategory: $listName");
    return mDataAgent.getMoreBooks(listName, offset).then((bookListByCategory) {
      List<BookVO>? bookList = bookListByCategory?.map((book) {
        book.category = listName;
        return book;
      }).toList();
      mBookDao.saveBooks(bookList);
      return Future.value(bookList);
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  // @override
  // Future<List<BookVO>?> getMoreBooksTest(String listName, String offset) {
  //   return mDataAgent
  //       .getMoreBooks(listName, offset)
  //       .then((bookListByCategory) => bookListByCategory)
  //       .catchError((error) {
  //     debugPrint(error.toString());
  //   });
  // }

  @override
  void getSearchedBookResults(String searchedWord) {
    mDataAgent.getSearchedBookResults(searchedWord).then((bookList) async {
      // mBookDaoForSearchResult.saveBooks(bookList, searchedWord);
      BookListForHiveVO bListForHive = BookListForHiveVO(bookList: bookList);
      mBookDaoForSearchResult.saveBooks(bListForHive, searchedWord);
      mBookDao.saveBooks(bListForHive.bookList);
    });
  }

  @override
  void saveShelfToShelfBox(ShelfVO shelf) {
    mShelfDao.saveSingleShelf(shelf);
    print("Shelf is saved......");
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
  Stream<List<BookVO>?> getMoreBookListByCategoryFromDatabase(
      String listName, String offset) {
    this.getMoreBookListByCategory(listName, offset);
    return mBookDao
        .getAllBooksEventStream()
        .startWith(mBookDao.getAllBooksByCategoryStream(listName))
        .map((event) => mBookDao.getAllBooksByCategoryForReactive(listName));
  }

  @override
  Stream<List<BookVO>?> getSearchedBookResultsFromDatabase(
      String searchedWord) {
    this.getSearchedBookResults(searchedWord);
    return mBookDaoForSearchResult
        .getBooksEventStream()
        .startWith(
            mBookDaoForSearchResult.getBooksBySearchedWordStream(searchedWord))
        .map((event) => mBookDaoForSearchResult
            .getBooksBySearchedWordForReactive(searchedWord));
  }

  @override
  Stream<List<ShelfVO>> getShelvesFromDatabase() {
    return mShelfDao
        .getAllShelvesEventStream()
        .startWith(mShelfDao.getAllShelvesStream())
        .map((event) => mShelfDao.getAllShelvesForReactive());
  }
}
