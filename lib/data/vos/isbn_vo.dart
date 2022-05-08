import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:library_app/persistence/hive_constants.dart';

part 'isbn_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_ISBN_VO, adapterName: "IsbnVOAdapter")
class IsbnVO {
  @JsonKey(name: "isbn10")
  @HiveField(0)
  String? isbn10;

  @JsonKey(name: "isbn13")
  @HiveField(1)
  String? isbn13;

  IsbnVO(this.isbn10, this.isbn13);

  factory IsbnVO.fromJson(Map<String, dynamic> json) =>
      _$IsbnVOFromJson(json);

  Map<String, dynamic> toJson() => _$IsbnVOToJson(this);
}