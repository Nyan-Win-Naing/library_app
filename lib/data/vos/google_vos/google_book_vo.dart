import 'package:json_annotation/json_annotation.dart';
import 'package:library_app/data/vos/google_vos/access_info_vo.dart';
import 'package:library_app/data/vos/google_vos/sale_info_vo.dart';
import 'package:library_app/data/vos/google_vos/search_info_vo.dart';
import 'package:library_app/data/vos/google_vos/volume_info_vo.dart';

part 'google_book_vo.g.dart';

@JsonSerializable()
class GoogleBookVO {
  @JsonKey(name: "kind")
  String? kind;

  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "etag")
  String? eTag;

  @JsonKey(name: "selfLink")
  String? selfLink;

  @JsonKey(name: "volumeInfo")
  VolumeInfoVO? volumeInfo;

  @JsonKey(name: "saleInfo")
  SaleInfoVO? saleInfo;

  @JsonKey(name: "accessInfo")
  AccessInfoVO? accessInfo;

  @JsonKey(name: "searchInfo")
  SearchInfoVO? searchInfo;

  GoogleBookVO(
    this.kind,
    this.id,
    this.eTag,
    this.selfLink,
    this.volumeInfo,
    this.saleInfo,
    this.accessInfo,
    this.searchInfo,
  );

  factory GoogleBookVO.fromJson(Map<String, dynamic> json) =>
      _$GoogleBookVOFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleBookVOToJson(this);
}
