import 'package:json_annotation/json_annotation.dart';
import 'package:library_app/data/vos/more_book_list_item_vo.dart';

part 'get_lists_response.g.dart';

@JsonSerializable()
class GetListsResponse {
  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "copyright")
  String? copyright;

  @JsonKey(name: "num_results")
  int? numResults;

  @JsonKey(name: "last_modified")
  String? lastModified;

  @JsonKey(name: "results")
  List<MoreBookListItemVO>? results;

  GetListsResponse(
    this.status,
    this.copyright,
    this.numResults,
    this.lastModified,
    this.results,
  );

  factory GetListsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetListsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetListsResponseToJson(this);
}
