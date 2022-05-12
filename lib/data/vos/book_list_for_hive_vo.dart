import 'package:hive/hive.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/persistence/hive_constants.dart';

part 'book_list_for_hive_vo.g.dart';

@HiveType(typeId: HIVE_TYPE_ID_BOOK_LIST_FOR_HIVE_VO, adapterName: "BookListForHiveVOAdapter")
class BookListForHiveVO {
  @HiveField(0)
  List<BookVO>? bookList;

  BookListForHiveVO({this.bookList});
}