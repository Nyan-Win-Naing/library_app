import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:library_app/blocs/library_bloc.dart';
import 'package:library_app/data/models/book_model.dart';
import 'package:library_app/data/models/book_model_impl.dart';
import 'package:library_app/data/vos/book_vo.dart';

class ChipsAndBookListBloc extends ChangeNotifier {
  int radioVal = 0;
  String sortByStatus = "";
  List<BookVO>? books;
  IconData? changeToView;

  /// Model
  BookModel bookModel = BookModelImpl();

  bool _disposed = false;

  ChipsAndBookListBloc({bool isLibraryPage = true}) {
    /// Get Book List For Library Page From Database
    if(isLibraryPage == true) {
      bookModel.getBookListForCarouselFromDatabase().listen((books) {
        this.books = books;
        radioVal = 2;
        notifyListeners();
        onTapBottomSheetRadioButton(radioVal);
      }).onError((error) {
        debugPrint(error.toString());
      });
    }

    /// Set initial Change To Icon Data
    changeToView = Icons.grid_view;
    notifyListeners();
  }

  void onTapBottomSheetRadioButton(int? value) {
    radioVal = value ?? 0;
    notifyListeners();
    print(radioVal);
    if(radioVal == 1) {
      sortByStatus = "Author";
      notifyListeners();
      books?.sort((a, b) => (a.author ?? "").compareTo(b.author ?? ""));
      this.books = List.of(books ?? []);
      notifyListeners();
    } else if(radioVal == 2) {
      sortByStatus = "Recent";
      notifyListeners();
      books?.sort((b, a) => (a.timestamp ?? 0).compareTo(b.timestamp ?? 0));
      this.books = List.of(books ?? []);
      notifyListeners();
    } else {
      sortByStatus = "Title";
      notifyListeners();
      books?.sort((a, b) => (a.title ?? "").compareTo(b.title ?? ""));
      this.books = List.of(books ?? []);
      notifyListeners();
    }
  }

  void onTapChangeView(IconData? iconData) {
    if(iconData == Icons.grid_view) {
      changeToView = Icons.grid_on;
      notifyListeners();
    } else if(iconData == Icons.grid_on) {
      changeToView = Icons.view_list_outlined;
      notifyListeners();
    } else {
      changeToView = Icons.grid_view;
      notifyListeners();
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