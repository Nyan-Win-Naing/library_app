import 'package:flutter/foundation.dart';
import 'package:library_app/data/models/book_model.dart';
import 'package:library_app/data/models/book_model_impl.dart';
import 'package:library_app/data/vos/shelf_vo.dart';

class YourShelvesBloc extends ChangeNotifier {

  /// States
  List<ShelfVO>? shelves;

  bool _disposed = false;

  /// Model
  BookModel bookModel = BookModelImpl();

  YourShelvesBloc() {
    /// Get Shelves From Database
    bookModel.getShelvesFromDatabase().listen((shelfList) {
      this.shelves = shelfList;
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