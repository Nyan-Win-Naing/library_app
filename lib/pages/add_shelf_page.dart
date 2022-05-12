import 'package:flutter/material.dart';
import 'package:library_app/data/models/book_model.dart';
import 'package:library_app/data/models/book_model_impl.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/resources/strings.dart';

class AddShelfPage extends StatefulWidget {

  @override
  State<AddShelfPage> createState() => _AddShelfPageState();
}

class _AddShelfPageState extends State<AddShelfPage> {
  TextEditingController addShelfFieldController = TextEditingController();

  bool _validate = false;

  /// Model
  BookModel bookModel = BookModelImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: MARGIN_MEDIUM_3),
          child: GestureDetector(
            onTap: () {
              print("Text: ${addShelfFieldController.text}");
              setState(() {
                addShelfFieldController.text.isEmpty ? _validate = true : _validate = false;
              });
              if(_validate == false) {
                ShelfVO shelf = ShelfVO(shelfName: addShelfFieldController.text, books: []);
                bookModel.saveShelfToShelfBox(shelf);
                Navigator.pop(context);
              }
            },
            child: const Icon(
              Icons.done,
              color: ADD_SHELF_PAGE_BACK_ICON_COLOR,
              size: MARGIN_XLARGE,
            ),
          ),
        ),
      ),
      body: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: PRIMARY_COLOR,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 1),
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
        child: TextField(
          controller: addShelfFieldController,
          style: const TextStyle(
            fontSize: MARGIN_LARGE,
          ),
          decoration: InputDecoration(
            errorText: _validate ? 'Value Can\'t Be Empty' : null,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
                width: 2,
              ),
            ),
            hintText: ADD_SHELF_TEXT_FIELD_HINT_TEXT,
            hintStyle: const TextStyle(
              color: ADD_SHELF_PAGE_TEXT_FIELD_HINT_TEXT_COLOR,
              fontSize: MARGIN_LARGE,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
