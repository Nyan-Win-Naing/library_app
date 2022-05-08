import 'package:flutter/material.dart';
import 'package:library_app/data/models/book_model.dart';
import 'package:library_app/data/models/book_model_impl.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/horizontal_book_list_item_vo.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/widgets/show_in_2x_grid_view.dart';

class MoreBookPage extends StatefulWidget {

  final HorizontalBookListItemVO? hBookListItem;

  MoreBookPage({required this.hBookListItem});

  @override
  State<MoreBookPage> createState() => _MoreBookPageState();
}

class _MoreBookPageState extends State<MoreBookPage> {

  /// Models
  BookModel bookModel = BookModelImpl();

  /// States
  List<BookVO>? books;


  @override
  void initState() {
    bookModel.getMoreBookListByCategoryFromDatabase(widget.hBookListItem?.listNameEncoded ?? "", "0")
    .listen((books) {
      if(mounted) {
        setState(() {
          this.books = books;
        });
      }
    }).onError((error) {
      debugPrint(error.toString());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: PRIMARY_COLOR,
        leading: Padding(
          padding: const EdgeInsets.only(left: MARGIN_MEDIUM_3),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          widget.hBookListItem?.listName ?? "",
          style: const TextStyle(
            color: Colors.black,
            fontSize: MARGIN_MEDIUM_2 + 2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: MARGIN_MEDIUM_3),
          child: ShowIn2xGridView(
            bookList: books ?? [],
            onTap: (title) {
              _navigateToBookDetailPage(context, title);
            },
            isHomePage: true,
          ),
        ),
      ),
    );
  }

  void _navigateToBookDetailPage(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailPage(title: title,),
      ),
    );
  }
}
