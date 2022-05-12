import "package:collection/collection.dart";
import 'package:library_app/dummy/dummy_book_list.dart';
import 'package:library_app/dummy/dummy_book_vo.dart';

void main() {
  List<int> numList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  print("Before change $numList");
  int i = 1;
  numList.forEach((num) {
    if(num % 2 == 0) {
      numList.insert(i++, numList.removeAt(numList.indexOf(num)));
    }
  });

  print("After change $numList");

}