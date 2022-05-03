import 'package:flutter/material.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';

class AddShelfPage extends StatefulWidget {

  @override
  State<AddShelfPage> createState() => _AddShelfPageState();
}

class _AddShelfPageState extends State<AddShelfPage> {
  TextEditingController addShelfFieldController = TextEditingController();

  bool _validate = false;

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
                Navigator.pop(context);
              }
            },
            child: Icon(
              Icons.done,
              color: Color.fromRGBO(2,119,197, 1.0),
              size: MARGIN_XLARGE,
            ),
          ),
        ),
      ),
      body: Container(
        height: 80,
        decoration: BoxDecoration(
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
        padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
        child: TextField(
          controller: addShelfFieldController,
          style: TextStyle(
            fontSize: MARGIN_LARGE,
          ),
          decoration: InputDecoration(
            errorText: _validate ? 'Value Can\'t Be Empty' : null,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
                width: 2,
              ),
            ),
            hintText: "Shelf name",
            hintStyle: TextStyle(
              color: Color.fromRGBO(158,158,158, 1.0),
              fontSize: MARGIN_LARGE,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
