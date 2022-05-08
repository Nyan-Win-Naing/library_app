import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/persistence/hive_constants.dart';

part 'horizontal_book_list_item_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_HORIZONTAL_BOOK_LIST_ITEM_VO, adapterName: "HorizontalBookListItemVOAdapter")
class HorizontalBookListItemVO {
  @JsonKey(name: "list_id")
  @HiveField(0)
  int? listId;

  @JsonKey(name: "list_name")
  @HiveField(1)
  String? listName;

  @JsonKey(name: "list_name_encoded")
  @HiveField(2)
  String? listNameEncoded;

  @JsonKey(name: "display_name")
  @HiveField(3)
  String? displayName;

  @JsonKey(name: "updated")
  @HiveField(4)
  String? updated;

  @JsonKey(name: "list_image")
  @HiveField(5)
  String? listImage;

  @JsonKey(name: "list_image_width")
  @HiveField(6)
  int? listImageWidth;

  @JsonKey(name: "list_image_height")
  @HiveField(7)
  int? listImageHeight;

  @JsonKey(name: "books")
  @HiveField(8)
  List<BookVO>? books;

  HorizontalBookListItemVO(
    this.listId,
    this.listName,
    this.listNameEncoded,
    this.displayName,
    this.updated,
    this.listImage,
    this.listImageWidth,
    this.listImageHeight,
    this.books,
  );

  factory HorizontalBookListItemVO.fromJson(Map<String, dynamic> json) =>
      _$HorizontalBookListItemVOFromJson(json);

  Map<String, dynamic> toJson() => _$HorizontalBookListItemVOToJson(this);
}
