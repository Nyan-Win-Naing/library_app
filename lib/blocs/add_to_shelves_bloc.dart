import 'package:flutter/foundation.dart';
import 'package:library_app/data/models/book_model.dart';
import 'package:library_app/data/models/book_model_impl.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/shelf_vo.dart';

class AddToShelvesBloc extends ChangeNotifier {

  /// States
  List<ShelfVO>? shelves;

  bool _disposed = false;

  /// Models
  BookModel bookModel = BookModelImpl();

  AddToShelvesBloc() {
    /// Get Shelves From Database
    bookModel.getShelvesFromDatabase().listen((shelfList) {
      shelves = shelfList;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });
  }

  void onCheck(bool value, ShelfVO? shelfVo) {
    shelves = shelves?.map((shelf) {
      if(shelf.shelfId == shelfVo?.shelfId) {
        shelf.isSelected = value;
      }
      return shelf;
    }).toList();
    notifyListeners();
  }

  bool isAnyShelfIsSelected() {
    if((shelves?.where((element) => element.isSelected == true).toList().length ?? 0) > 0) {
      return true;
    } else {
      return false;
    }
  }

  void onTapDone(BookVO? bookVo) {
    List<ShelfVO> selectedShelves = shelves?.where((shelf) => shelf.isSelected == true).toList() ?? [];
    print("length is ${selectedShelves.length}..............");
    if(bookVo != null) {
      selectedShelves.forEach((shelf) {
        bookVo.timestamp = DateTime.now().millisecondsSinceEpoch;
        shelf.books?.add(bookVo);
        shelf.isSelected = false;
        bookModel.saveShelfToShelfBox(shelf);
      });
    }
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