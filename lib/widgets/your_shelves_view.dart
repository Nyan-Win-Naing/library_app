import 'package:flutter/material.dart';
import 'package:library_app/blocs/your_shelves_bloc.dart';
import 'package:library_app/data/models/book_model.dart';
import 'package:library_app/data/models/book_model_impl.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/pages/add_shelf_page.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/resources/strings.dart';
import 'package:library_app/viewitems/shelf_item.dart';
import 'package:provider/provider.dart';

class YourShelvesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => YourShelvesBloc(),
      child: Container(
        height: MediaQuery.of(context).size.height * 2.2 / 3,
        child: Stack(
          children: [
            Selector<YourShelvesBloc, List<ShelfVO>>(
              selector: (context, bloc) => bloc.shelves ?? [],
              builder: (context, shelves, child) =>
                  YourShelvesListSectionView(
                    shelves: shelves,
                  ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: CreateShelfButtonSectionView(),
            ),
          ],
        ),
      ),
    );
  }
}

class YourShelvesListSectionView extends StatelessWidget {
  List<ShelfVO> shelves;

  YourShelvesListSectionView({required this.shelves});

  @override
  Widget build(BuildContext context) {
    print("Shelf List is $shelves.......");
    return (shelves.isNotEmpty)
        ? ListView.builder(
            padding: const EdgeInsets.only(top: MARGIN_MEDIUM_3),
            itemCount: shelves.length,
            // shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ShelfItem(shelf: shelves[index]);
            },
          )
        : const Center(
            child: Text(
              "Your shelf list is empty now.",
              style: TextStyle(
                color: SECONDARY_COLOR,
                fontSize: MARGIN_MEDIUM_2,
              ),
            ),
          );
  }
}

class CreateShelfButtonSectionView extends StatelessWidget {
  const CreateShelfButtonSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: MARGIN_XLARGE),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddShelfPage(),
            ),
          );
        },
        child: Container(
          key: Key("createNewShelf"),
          width: 130,
          height: 45,
          decoration: BoxDecoration(
            color: TAB_BAR_SELECTED_COLOR,
            borderRadius: BorderRadius.circular(MARGIN_LARGE),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 5),
              )
            ],
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.create_outlined,
                  color: PRIMARY_COLOR,
                  size: MARGIN_MEDIUM_3,
                ),
                SizedBox(width: MARGIN_MEDIUM),
                Text(
                  YOUR_SHELVES_CREATE_NEW_BUTTON_TEXT,
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: MARGIN_CARD_MEDIUM_2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
