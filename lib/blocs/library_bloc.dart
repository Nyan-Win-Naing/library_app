import 'package:flutter/foundation.dart';
import 'package:library_app/data/models/book_model.dart';
import 'package:library_app/data/models/book_model_impl.dart';
import 'package:library_app/data/vos/book_vo.dart';

class LibraryBloc extends ChangeNotifier {
  /// States
  List<BookVO>? books;

  /// Models
  BookModel bookModel = BookModelImpl();

  bool _disposed = false;

  LibraryBloc() {
    /// Get Book List For Library Page From Database
    // bookModel.getBookListForCarouselFromDatabase().listen((books) {
    //   this.books = books;
    //   notifyListeners();
    // }).onError((error) {
    //   debugPrint(error.toString());
    // });
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