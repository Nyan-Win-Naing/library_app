import 'package:flutter/foundation.dart';
import 'package:library_app/data/models/book_model.dart';
import 'package:library_app/data/models/book_model_impl.dart';
import 'package:library_app/data/vos/book_vo.dart';

class BookDetailBloc extends ChangeNotifier {
  /// States
  BookVO? book;
  List<BookVO>? bookList;

  /// Models
  BookModel bookModel = BookModelImpl();

  bool _disposed = false;

  BookDetailBloc(String title) {
    /// Get Book Detail From Database
    bookModel.getBookDetailFromDatabase(title).listen((bookDetail) {
      book = bookDetail;
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
}