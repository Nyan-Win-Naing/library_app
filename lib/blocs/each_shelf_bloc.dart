import 'package:flutter/foundation.dart';
import 'package:library_app/data/models/book_model.dart';
import 'package:library_app/data/models/book_model_impl.dart';
import 'package:library_app/data/vos/shelf_vo.dart';

class EachShelfBloc extends ChangeNotifier {
  /// States
  bool isTapRename = false;
  ShelfVO? shelf;

  /// Model
  BookModel bookModel = BookModelImpl();

  bool _disposed = false;

  EachShelfBloc(ShelfVO? shelfVo) {
    shelf = shelfVo;
    notifyListeners();
  }

  void onTapRename() {
    isTapRename = true;
    notifyListeners();
  }

  void onSubmit(String name, ShelfVO? shelf) {
    bookModel
        .getSingleShelfFromDatabaseNotReactive(shelf?.shelfId ?? "")
        .then((shelfVo) {
      if (shelfVo != null) {
        shelfVo.shelfName = name;
        bookModel.saveShelfToShelfBox(shelfVo);
        isTapRename = false;
        notifyListeners();
        this.shelf = ShelfVO(
          shelfName: shelfVo.shelfName ?? "",
          books: shelfVo.books ?? [],
          isSelected: shelfVo.isSelected ?? false,
          shelfId: shelfVo.shelfId ?? "",
        );
        notifyListeners();
      }
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void onTapDelete(String id) {
    bookModel.removeShelfFromShelfBox(id);
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
