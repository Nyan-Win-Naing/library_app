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

  @HiveField(2)
  bool? isSelected;

  @HiveField(3)
  String? shelfId;

  ShelfVO({this.shelfName, this.books, this.isSelected, this.shelfId});

  @override
  String toString() {
    return 'ShelfVO{shelfName: $shelfName, books: $books, isSelected: $isSelected, shelfId: $shelfId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShelfVO &&
          runtimeType == other.runtimeType &&
          shelfName == other.shelfName &&
          books == other.books &&
          isSelected == other.isSelected &&
          shelfId == other.shelfId;

  @override
  int get hashCode =>
      shelfName.hashCode ^
      books.hashCode ^
      isSelected.hashCode ^
      shelfId.hashCode;
}
