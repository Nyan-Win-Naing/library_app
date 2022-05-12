import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:library_app/data/vos/book_list_for_hive_vo.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/buy_link_vo.dart';
import 'package:library_app/data/vos/get_overview_result_vo.dart';
import 'package:library_app/data/vos/horizontal_book_list_item_vo.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:library_app/pages/each_shelf_page.dart';
import 'package:library_app/pages/library_app.dart';
import 'package:library_app/pages/more_books_page.dart';
import 'package:library_app/persistence/hive_constants.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(BookVOAdapter());
  Hive.registerAdapter(BuyLinkVOAdapter());
  Hive.registerAdapter(GetOverviewResultVOAdapter());
  Hive.registerAdapter(HorizontalBookListItemVOAdapter());
  Hive.registerAdapter(BookListForHiveVOAdapter());

  await Hive.openBox<BookVO>(BOX_NAME_BOOK_VO);
  await Hive.openBox<BookVO>(BOX_NAME_BOOK_VO_FOR_CAROUSEL);
  await Hive.openBox<BookListForHiveVO>(BOX_NAME_BOOK_VO_FOR_SEARCH_RESULT);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LibraryApp(),
    );
  }
}

