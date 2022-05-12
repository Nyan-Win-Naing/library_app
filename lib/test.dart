import "package:collection/collection.dart";
import 'package:library_app/dummy/dummy_book_list.dart';
import 'package:library_app/dummy/dummy_book_vo.dart';

void main() {
  var data = groupBy(dummyBookList, (DummyBookVO bookVo) => bookVo.category);
  print(data["abc"]);
}