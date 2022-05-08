import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/isbn_vo.dart';
import 'package:library_app/data/vos/review_vo.dart';
import 'package:library_app/persistence/hive_constants.dart';

part 'more_book_list_item_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_MORE_BOOK_LIST_ITEM_VO, adapterName: "MoreBookListItemVOAdapter")
class MoreBookListItemVO {
  @JsonKey(name: "list_name")
  @HiveField(0)
  String? listName;

  @JsonKey(name: "display_name")
  @HiveField(1)
  String? displayName;

  @JsonKey(name: "bestsellers_date")
  @HiveField(2)
  String? bestsellersDate;

  @JsonKey(name: "published_date")
  @HiveField(3)
  String? publishedDate;

  @JsonKey(name: "rank")
  @HiveField(4)
  int? rank;

  @JsonKey(name: "rank_last_week")
  @HiveField(5)
  int? rankLastWeek;

  @JsonKey(name: "weeks_on_list")
  @HiveField(6)
  int? weeksOnList;

  @JsonKey(name: "asterisk")
  @HiveField(7)
  int? asterisk;

  @JsonKey(name: "dagger")
  @HiveField(8)
  int? dagger;

  @JsonKey(name: "amazon_product_url")
  @HiveField(9)
  String? amazonProductUrl;

  @JsonKey(name: "isbns")
  @HiveField(10)
  List<IsbnVO>? isbns;

  @JsonKey(name: "book_details")
  @HiveField(11)
  List<BookVO>? bookDetails;

  @JsonKey(name: "reviews")
  @HiveField(12)
  List<ReviewVO>? reviews;

  MoreBookListItemVO({
    this.listName,
    this.displayName,
    this.bestsellersDate,
    this.publishedDate,
    this.rank,
    this.rankLastWeek,
    this.weeksOnList,
    this.asterisk,
    this.dagger,
    this.amazonProductUrl,
    this.isbns,
    this.bookDetails,
    this.reviews,
  });

  factory MoreBookListItemVO.fromJson(Map<String, dynamic> json) =>
      _$MoreBookListItemVOFromJson(json);

  Map<String, dynamic> toJson() => _$MoreBookListItemVOToJson(this);
}
