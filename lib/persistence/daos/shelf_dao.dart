import 'dart:async';

import 'package:hive/hive.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/persistence/hive_constants.dart';

class ShelfDao {
  static final ShelfDao _singleton = ShelfDao._internal();

  factory ShelfDao() {
    return _singleton;
  }

  ShelfDao._internal();

  void saveSingleShelf(ShelfVO? shelf) async {
    if(shelf != null) {
      await getShelfBox().put(shelf.shelfId ?? "", shelf);
    }
  }

  ShelfVO? getShelfById(String id) {
    return getShelfBox().get(id);
  }

  void removeShelfFromHive(String id) {
    getShelfBox().delete(id);
    print("Delete shelf successfully........");
  }

  List<ShelfVO> getAllShelves() {
    return getShelfBox().values.toList();
  }

  Box<ShelfVO> getShelfBox() {
    return Hive.box<ShelfVO>(BOX_NAME_SHELF_VO);
  }

  /// Reactive Programming
  Stream<void> getAllShelvesEventStream() {
    return getShelfBox().watch();
  }

  Stream<ShelfVO?> getShelfByIdStream(String id) {
    return Stream.value(getShelfById(id));
  }

  Stream<List<ShelfVO>> getAllShelvesStream() {
    return Stream.value(getAllShelves());
  }

  ShelfVO? getShelfByIdForReactive(String id) {
    if(getShelfById(id) != null) {
      return getShelfById(id);
    } else {
      return ShelfVO();
    }
  }

  List<ShelfVO> getAllShelvesForReactive() {
    if(getAllShelves() != null && getAllShelves().isNotEmpty) {
      return getAllShelves();
    } else {
      return [];
    }
  }
}
