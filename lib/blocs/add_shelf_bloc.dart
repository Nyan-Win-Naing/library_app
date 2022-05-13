import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:library_app/data/models/book_model.dart';
import 'package:library_app/data/models/book_model_impl.dart';
import 'package:library_app/data/vos/shelf_vo.dart';

class AddShelfBloc extends ChangeNotifier {

  /// States
  bool validate = false;

  bool _disposed = false;

  /// Model
  BookModel bookModel = BookModelImpl();

  AddShelfBloc() {

  }

  bool onTapDone(String text) {
    if(text.isEmpty) {
      validate = true;
      notifyListeners();
      return validate;
    } else {
      validate = false;
      notifyListeners();
      ShelfVO shelf = ShelfVO(
        shelfName: text,
        books: [],
        isSelected: false,
      );
      shelf.shelfId = generateRandomString(5);
      bookModel.saveShelfToShelfBox(shelf);
      return validate;
    }
  }


  /// Generate Random String Id For Shelf
  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
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