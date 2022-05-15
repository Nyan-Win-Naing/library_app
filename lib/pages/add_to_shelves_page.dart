import 'package:flutter/material.dart';
import 'package:library_app/blocs/add_to_shelves_bloc.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/viewitems/shelf_item.dart';
import 'package:provider/provider.dart';

class AddToShelvesPage extends StatefulWidget {

  final BookVO? book;


  AddToShelvesPage({required this.book});

  @override
  State<AddToShelvesPage> createState() => _AddToShelvesPageState();
}

class _AddToShelvesPageState extends State<AddToShelvesPage> {
  List<ShelfVO> dummyShelves = [
    ShelfVO(shelfName: "Shelf One", books: []),
    ShelfVO(shelfName: "Shelf Two", books: [])
  ];

  @override
  Widget build(BuildContext context) {
    bool hasSelectShelf = false;

    if (dummyShelves
            .where((element) => element.isSelected == true)
            .toList()
            .length >
        0) {
      hasSelectShelf = true;
    } else {
      hasSelectShelf = false;
    }

    return ChangeNotifierProvider(
      create: (context) => AddToShelvesBloc(),
      child: Selector<AddToShelvesBloc, List<ShelfVO>>(
        selector: (context, bloc) => bloc.shelves ?? [],
        shouldRebuild: (previous, next) => previous != next,
        builder: (context, shelves, child) {
          print("Shelves are $shelves ............");
          AddToShelvesBloc bloc = Provider.of(context, listen: false);
          return Scaffold(
            backgroundColor: PRIMARY_COLOR,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: PRIMARY_COLOR,
              centerTitle: true,
              title: const Text(
                "Add to shelves",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: MARGIN_MEDIUM_2 + 2,
                ),
              ),
              actions: [
                (!bloc.isAnyShelfIsSelected())
                    ? CrossButtonView()
                    : Padding(
                  padding: EdgeInsets.only(right: MARGIN_MEDIUM_2),
                  child: GestureDetector(
                    onTap: () {
                      bloc.onTapDone(widget.book);
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.check,
                      color: Colors.black54,
                      key: Key("bookAddToShelfDone"),
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: (shelves.isNotEmpty)
                  ? ListView.builder(
                padding: EdgeInsets.only(top: MARGIN_XLARGE),
                itemCount: shelves.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ShelfItem(
                    shelf: shelves[index],
                    isAddToShelvesPage: true,
                    keyName: "shelf$index",
                  );
                },
              )
                  : const Center(
                child: Text(
                  "Your shelf list is empty.",
                  style: TextStyle(
                    color: SECONDARY_COLOR,
                    fontSize: MARGIN_MEDIUM_2 + 2,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CrossButtonView extends StatelessWidget {
  const CrossButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: MARGIN_MEDIUM_2),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.close,
            color: Colors.black54,
          ),
        ),
      );
  }
}
