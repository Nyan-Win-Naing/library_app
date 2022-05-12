import 'package:hive/hive.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/persistence/hive_constants.dart';

part 'shelf_vo.g.dart';

@HiveType(typeId: HIVE_TYPE_ID_SHELF_VO, adapterName: "ShelfVOAdapter")
class ShelfVO {
  @HiveField(0)
  String? shelfName;

  @HiveField(1)
  List<BookVO>? books;

  ShelfVO({this.shelfName, this.books});

  @override
  String toString() {
    return 'ShelfVO{shelfName: $shelfName, books: $books}';
  }
}