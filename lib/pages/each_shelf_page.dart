import 'package:flutter/material.dart';
import 'package:library_app/blocs/each_shelf_bloc.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/resources/strings.dart';
import 'package:library_app/widgets/chips_and_book_list_view.dart';
import 'package:provider/provider.dart';

class EachShelfPage extends StatelessWidget {
  final ShelfVO? shelf;

  EachShelfPage({required this.shelf});

  List<dynamic> chipNames = [
    Icons.close,
    "Ebooks",
    "Downloaded",
    "Not started",
    "In progress",
    "Stephen Hawking",
    "Molly Fitz",
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EachShelfBloc(shelf),
      child: Selector<EachShelfBloc, ShelfVO?>(
        selector: (context, bloc) => bloc.shelf,
        builder: (context, shelf, child) => Scaffold(
          backgroundColor: PRIMARY_COLOR,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: PRIMARY_COLOR,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.keyboard_arrow_left_sharp,
                key: Key("eachShelfBack"),
                color: SECONDARY_COLOR,
                size: MARGIN_XXLARGE,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: MARGIN_MEDIUM_3),
                child: PopupMenuButton(
                  icon: const Icon(
                    Icons.more_horiz,
                    key: Key("shelfPopupMenu"),
                    color: SECONDARY_COLOR,
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text(
                        EACH_SHELF_PAGE_POP_UP_MENU_ITEM_1,
                        key: Key("renameShelf"),
                      ),
                      value: 1,
                      onTap: () {
                        EachShelfBloc bloc =
                            Provider.of<EachShelfBloc>(context, listen: false);
                        bloc.onTapRename();
                      },
                    ),
                    const PopupMenuItem(
                      child: Text(
                        EACH_SHELF_PAGE_POP_UP_MENU_ITEM_2,
                        key: Key("deleteShelf"),
                      ),
                      value: 2,
                    ),
                  ],
                  onSelected: (index) {
                    if (index == 2) {
                      showConfirmDialog(context, shelf);
                      // Navigator.pop(context);
                    }
                  },
                ),
              )
            ],
          ),
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: MARGIN_MEDIUM_3,
                      right: MARGIN_MEDIUM_3,
                      top: MARGIN_XXLARGE,
                      bottom: MARGIN_MEDIUM_2,
                    ),
                    child: BookShelfNameAndDescriptionSectionView(
                      shelf: shelf,
                    ),
                  ),
                  const SizedBox(height: MARGIN_SMALL),
                  Container(
                    height: 1,
                    color: HORIZONTAL_DIVIDER_LINE_COLOR,
                  ),
                  const SizedBox(height: MARGIN_MEDIUM),
                  ChipsAndBookListView(
                    chipNames: chipNames,
                    runtimeType: runtimeType,
                    books: shelf?.books ?? [],
                    isLibraryPage: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showConfirmDialog(BuildContext context, ShelfVO? shelf) {
    EachShelfBloc bloc = Provider.of<EachShelfBloc>(context, listen: false);
    Widget cancelButton = FlatButton(
      onPressed: () {
        Navigator.pop(context, false);
      },
      child: Text(
        "CANCEL",
        style: TextStyle(
          fontSize: MARGIN_MEDIUM_3,
          color: TAB_BAR_SELECTED_COLOR,
        ),
      ),
    );
    Widget deleteButton = FlatButton(
      onPressed: () {
        bloc.onTapDelete(shelf?.shelfId ?? "");
        Navigator.pop(context, true);
      },
      child: Text(
        "DELETE",
        style: TextStyle(
          fontSize: MARGIN_MEDIUM_3,
          color: TAB_BAR_SELECTED_COLOR,
        ),
      ),
    );

    /// setup the Confirm Dialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Delete '${shelf?.shelfName}'?",
        style: const TextStyle(
          fontSize: MARGIN_MEDIUM_3,
        ),
      ),
      content: const Text(
        "This shelf will be deleted from all of your devides. Purchases, samples, uplaods and active"
        "rentals on this shelf will stay in 'Your books'.",
        style: TextStyle(
          fontSize: MARGIN_MEDIUM_2,
          height: 1.2,
          color: BOTTOM_SHEET_LIST_TILE_ICON_COLOR,
        ),
      ),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );

    /// show the dialog
    showDialog(
      context: context,
      builder: (context) {
        return alert;
      },
    ).then((exit) {
      print("Exit is $exit ..........");
      if (exit) {
        Navigator.pop(context);
      }
    });
  }
}

class BookShelfNameAndDescriptionSectionView extends StatelessWidget {
  final ShelfVO? shelf;

  BookShelfNameAndDescriptionSectionView({required this.shelf});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Selector<EachShelfBloc, bool>(
          selector: (context, bloc) => bloc.isTapRename,
          builder: (context, isTapRename, child) {
            return (!isTapRename)
                ? Text(
                    shelf?.shelfName ?? "",
                    style: const TextStyle(
                        fontSize: MARGIN_LARGE,
                        fontWeight: FontWeight.w600,
                        height: 1.2),
                  )
                : TextFormField(
                    style: TextStyle(
                      fontSize: MARGIN_LARGE,
                    ),
                    key: Key("shelfRenameField"),
                    initialValue: shelf?.shelfName ?? "",
                    autofocus: true,
                    onFieldSubmitted: (value) {
                      EachShelfBloc bloc =
                          Provider.of<EachShelfBloc>(context, listen: false);
                      bloc.onSubmit(value, shelf);
                    },
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      hintText: ADD_SHELF_TEXT_FIELD_HINT_TEXT,
                      hintStyle: TextStyle(
                        color: ADD_SHELF_PAGE_TEXT_FIELD_HINT_TEXT_COLOR,
                        fontSize: MARGIN_LARGE,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
          },
        ),
        SizedBox(height: MARGIN_MEDIUM),
        Text(
          "${shelf?.books?.length} books",
          style: const TextStyle(
            color: EACH_SHELF_PAGE_BOOK_COUNT_TEXT_COLOR,
            fontSize: MARGIN_MEDIUM_2,
          ),
        ),
      ],
    );
  }
}
