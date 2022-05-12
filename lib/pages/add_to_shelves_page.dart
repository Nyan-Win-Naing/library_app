import 'package:flutter/material.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';

class AddToShelvesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: PRIMARY_COLOR,
        centerTitle: true,
        title: Text(
          "Add to shelves",
          style: TextStyle(
            color: Colors.black87,
            fontSize: MARGIN_MEDIUM_2 + 2,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: MARGIN_MEDIUM_2),
            child: Icon(
              Icons.close,
              color: Colors.black54,
            ),
          )
        ],
      ),
    );
  }
}
