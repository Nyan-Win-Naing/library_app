import 'package:flutter/material.dart';
import 'package:library_app/blocs/add_to_shelves_bloc.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/pages/each_shelf_page.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:provider/provider.dart';

class ShelfItem extends StatefulWidget {
  final ShelfVO? shelf;
  bool? isAddToShelvesPage;
  final String keyName;

  ShelfItem({required this.shelf, this.isAddToShelvesPage = false, this.keyName = ""});

  @override
  State<ShelfItem> createState() => _ShelfItemState();
}

class _ShelfItemState extends State<ShelfItem> {

  @override
  Widget build(BuildContext context) {

    widget.shelf?.books?.sort((b, a) => (a.timestamp ?? 0).compareTo(b.timestamp ?? 0));

    return Padding(
      padding: const EdgeInsets.only(bottom: MARGIN_LARGE),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EachShelfPage(shelf: widget.shelf),
                ),
              );
            },
            child: Container(
              height: 90,
              // color: Colors.black26,
              padding: EdgeInsets.only(
                left: (!(widget.isAddToShelvesPage ?? false))
                    ? MARGIN_MEDIUM_3
                    : MARGIN_MEDIUM_2,
                right: (!(widget.isAddToShelvesPage ?? false))
                    ? MARGIN_MEDIUM_3
                    : 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(MARGIN_SMALL),
                          image: DecorationImage(
                            image: NetworkImage(
                              ((widget.shelf?.books?.isNotEmpty ?? false))
                                  ? widget.shelf?.books?.first.bookImage ??
                                      "https://lightning.od-cdn.com/static/img/no-cover_en_US.a8920a302274ea37cfaecb7cf318890e.jpg"
                                  : "https://lightning.od-cdn.com/static/img/no-cover_en_US.a8920a302274ea37cfaecb7cf318890e.jpg",
                            ),
                            fit: BoxFit.fill,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(5, 0),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: MARGIN_MEDIUM_2 + 2),
                      Container(
                        width: MediaQuery.of(context).size.width * 1.7 / 3,
                        // color: Colors.blue,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.shelf?.shelfName ?? "",
                              style: const TextStyle(
                                fontSize: MARGIN_MEDIUM_2 - 1,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: MARGIN_MEDIUM),
                            Text(
                              "${widget.shelf?.books?.length} books",
                              style: const TextStyle(
                                color: Color.fromRGBO(113, 118, 121, 1.0),
                                fontSize: MARGIN_CARD_MEDIUM_2,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  (widget.isAddToShelvesPage ?? false)
                      ? Checkbox(
                          checkColor: PRIMARY_COLOR,
                          value: widget.shelf?.isSelected ?? false,
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          key: Key(widget.keyName),
                          onChanged: (value) {
                            AddToShelvesBloc bloc =
                                Provider.of(context, listen: false);
                            bloc.onCheck(value ?? false, widget.shelf);
                          },
                        )
                      : const Icon(
                          Icons.arrow_forward_ios,
                          color: SECONDARY_COLOR,
                          size: MARGIN_MEDIUM_3,
                        ),
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            color: Color.fromRGBO(219, 220, 222, 1.0),
          ),
        ],
      ),
    );
  }
}
