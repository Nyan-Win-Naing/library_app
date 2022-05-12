import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:library_app/blocs/library_bloc.dart';
import 'package:library_app/data/models/book_model.dart';
import 'package:library_app/data/models/book_model_impl.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/chip_vo.dart';

class ChipsAndBookListBloc extends ChangeNotifier {
  int radioVal = 0;
  String sortByStatus = "";
  List<BookVO>? books;
  IconData? changeToView;

  /// States
  List<ChipVO>? chips;
  int i = 0;
  List<ChipVO>? originalChips;
  List<BookVO>? originalBookList;

  /// Model
  BookModel bookModel = BookModelImpl();

  bool _disposed = false;

  ChipsAndBookListBloc({bool isLibraryPage = true}) {
    /// Get Book List For Library Page From Database
    if (isLibraryPage == true) {
      bookModel.getBookListForCarouselFromDatabase().listen((books) {
        this.books = books;
        radioVal = 2;
        notifyListeners();
        originalBookList = List.of(books ?? []);
        onTapBottomSheetRadioButton(radioVal);

        getCategoriesFromViewedBooks(books);
      }).onError((error) {
        debugPrint(error.toString());
      });
    }

    /// Set initial Change To Icon Data
    changeToView = Icons.grid_view;
    notifyListeners();
  }

  void getCategoriesFromViewedBooks(List<BookVO>? books) {
    List<ChipVO> bookChips = books?.map((book) {
          return ChipVO(chipName: book.category ?? "", isSelected: false);
        }).toList() ??
        [];

    chips = bookChips.toSet().toList();
    notifyListeners();
    originalChips = List.of(chips ?? []);
  }

  void onTapBottomSheetRadioButton(int? value) {
    radioVal = value ?? 0;
    notifyListeners();
    print(radioVal);
    if (radioVal == 1) {
      sortByStatus = "Author";
      notifyListeners();
      books?.sort((a, b) => (a.author ?? "").compareTo(b.author ?? ""));
      this.books = List.of(books ?? []);
      notifyListeners();
    } else if (radioVal == 2) {
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
    if (iconData == Icons.grid_view) {
      changeToView = Icons.grid_on;
      notifyListeners();
    } else if (iconData == Icons.grid_on) {
      changeToView = Icons.view_list_outlined;
      notifyListeners();
    } else {
      changeToView = Icons.grid_view;
      notifyListeners();
    }
  }

  void onSelectChip(int index) {
    if(chips?[index].isSelected == false) {
      this.books = [];
      chips?[index].isSelected = true;

      /// Move Item to front of the list
      if (chips?[index].isSelected == true) {
        print("Need to Change index is : $i");
        chips?.insert(
            i,
            chips?.removeAt(chips?.indexOf(chips?[index] ?? ChipVO()) ?? 0) ??
                ChipVO());
        ++i;
      }

      /// Create a Cross Button when select
      if (chips?[0].chipName.runtimeType != IconData) {
        chips?.insert(0, ChipVO(chipName: Icons.close, isSelected: false));
        ++i;
      }

      chips = List.of(chips ?? []);
      notifyListeners();

      chips?.forEach((chip) {
        if(chip.isSelected == true) {
          this.books = (books ?? []) + (originalBookList?.where((book) => (book.category ?? "") == chip.chipName).toList() ?? []);
          notifyListeners();
        }
      });
    }
  }


  void onTapCloseButton() {
    print("On Tap");
    originalChips?.forEach((chip) {
      chip.isSelected = false;
    });
    this.chips = List.of(originalChips ?? []);
    notifyListeners();
    this.books = List.of(originalBookList ?? []);
    notifyListeners();
    i = 0;
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
