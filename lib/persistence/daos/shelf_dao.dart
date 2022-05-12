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
      await getShelfBox().put(shelf.shelfName ?? "", shelf);
    }
  }

  ShelfVO? getShelfByTitle(String name) {
    return getShelfBox().get(name);
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

  Stream<ShelfVO?> getShelfByTitleStream(String name) {
    return Stream.value(getShelfByTitle(name));
  }

  Stream<List<ShelfVO>> getAllShelvesStream() {
    return Stream.value(getAllShelves());
  }

  ShelfVO? getShelfByTitleForReactive(String name) {
    if(getShelfByTitle(name) != null) {
      return getShelfByTitle(name);
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
