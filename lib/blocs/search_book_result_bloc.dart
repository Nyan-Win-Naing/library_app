import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:library_app/data/vos/book_vo.dart';

class SearchBookResultBloc extends ChangeNotifier {
  /// States
  Map<String, List<BookVO>>? bookMap;
  List<String>? keyList;

  bool _disposed = false;


  SearchBookResultBloc(List<BookVO> suggestionBooksList) {
    bookMap = groupBy(suggestionBooksList, (BookVO book) => book.category ?? "");
    notifyListeners();
    keyList = bookMap?.keys.toList();
    notifyListeners();
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