import 'package:flutter/foundation.dart';
import 'package:library_app/data/models/book_model.dart';
import 'package:library_app/data/models/book_model_impl.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/horizontal_book_list_item_vo.dart';

class HomeBloc extends ChangeNotifier {

  /// States
  List<HorizontalBookListItemVO>? hBookLists;
  List<BookVO>? bookListForCarousel;

  /// Model
  BookModel bModel = BookModelImpl();

  bool _disposed = false;

  HomeBloc() {
    /// Get Horizontal Book List Items
    bModel.getHorizontalBookListItems("2022-05-06").then((hBookLists) {
      this.hBookLists = hBookLists;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// Get Book List For Carousel From Database
    bModel.getBookListForCarouselFromDatabase().listen((bookList) {
      this.bookListForCarousel = bookList;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if(!_disposed) {
      super.notifyListeners();
    }
  }

  void getRelatedBooks(String title) {
    bModel.getBookDetailFromDatabase(title).listen((bookDetail) {
      bModel.getMoreBookListByCategoryFromDatabase(bookDetail?.category ?? "", "");
    });
  }
}