import 'package:flutter/foundation.dart';
import 'package:library_app/data/models/book_model.dart';
import 'package:library_app/data/models/book_model_impl.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/resources/debouncer.dart';

class SearchBookBloc extends ChangeNotifier {
  /// States
  List<BookVO>? searchResults;

  final debouncer = Debouncer(milliseconds: 500);
  bool _disposed = false;

  /// Models
  BookModel bookModel = BookModelImpl();

  SearchBookBloc() {
    searchResults = [];
    notifyListeners();
  }

  void getSearchResultsFromDatabase(String input) {
    if(input.isNotEmpty) {
      /// Get Search Results From Database
      bookModel.getSearchedBookResultsFromDatabase(input).listen((bookList) {
        this.searchResults = bookList;
        notifyListeners();
      }).onError((error) {
        debugPrint(error.toString());
      });
    } else {
      this.searchResults = [];
      notifyListeners();
    }
  }

  void onTextChange(String input) {
    debouncer.run(() {
      getSearchResultsFromDatabase(input);
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