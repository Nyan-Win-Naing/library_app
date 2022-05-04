import 'package:flutter/material.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/widgets/show_in_2x_grid_view.dart';

class MoreBookPage extends StatelessWidget {

  final String title;

  MoreBookPage({required this.title});

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
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: MARGIN_MEDIUM_2 + 2,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: MARGIN_MEDIUM_3),
            child: ShowIn2xGridView(
              onTap: () {
                _navigateToBookDetailPage(context);
              },
              isHomePage: true,
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToBookDetailPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailPage(),
      ),
    );
  }
}
