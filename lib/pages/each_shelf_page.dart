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
        builder: (context, shelf, child) =>
            Scaffold(
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
                        color: SECONDARY_COLOR,
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text(EACH_SHELF_PAGE_POP_UP_MENU_ITEM_1),
                          value: 1,
                          onTap: () {
                            EachShelfBloc bloc = Provider.of<EachShelfBloc>(context, listen: false);
                            bloc.onTapRename();
                          },
                        ),
                        const PopupMenuItem(
                          child: Text(EACH_SHELF_PAGE_POP_UP_MENU_ITEM_2),
                          value: 2,
                        ),
                      ],
                      onSelected: (index) {
                        if (index == 2) {
                          Navigator.pop(context);
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
                        child: BookShelfNameAndDescriptionSectionView(shelf: shelf,),
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
            return (!isTapRename) ?
            Text(
              shelf?.shelfName ?? "",
              style: const TextStyle(
                  fontSize: MARGIN_LARGE, fontWeight: FontWeight.w600, height: 1.2),
            ) :
            TextFormField(
              style: TextStyle(
                fontSize: MARGIN_LARGE,
              ),
              initialValue: shelf?.shelfName ?? "",
              autofocus: true,
              onFieldSubmitted: (value) {
                EachShelfBloc bloc = Provider.of<EachShelfBloc>(context, listen: false);
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
