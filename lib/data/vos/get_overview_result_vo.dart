import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:library_app/data/vos/horizontal_book_list_item_vo.dart';
import 'package:library_app/persistence/hive_constants.dart';

part 'get_overview_result_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_GET_OVERVIEW_RESULT_VO, adapterName: "GetOverviewResultVOAdapter")
class GetOverviewResultVO {
  @JsonKey(name: "bestsellers_date")
  @HiveField(0)
  String? bestsellersDate;

  @JsonKey(name: "published_date")
  @HiveField(1)
  String? publishedDate;

  @JsonKey(name: "published_date_description")
  @HiveField(2)
  String? publishedDateDescription;

  @JsonKey(name: "previous_published_date")
  @HiveField(3)
  String? previousPublishedDate;

  @JsonKey(name: "next_published_date")
  @HiveField(4)
  String? nextPublishedDate;

  @JsonKey(name: "lists")
  @HiveField(5)
  List<HorizontalBookListItemVO>? lists;

  GetOverviewResultVO(
    this.bestsellersDate,
    this.publishedDate,
    this.publishedDateDescription,
    this.previousPublishedDate,
    this.nextPublishedDate,
    this.lists,
  );

  factory GetOverviewResultVO.fromJson(Map<String, dynamic> json) =>
      _$GetOverviewResultVOFromJson(json);

  Map<String, dynamic> toJson() => _$GetOverviewResultVOToJson(this);
}
