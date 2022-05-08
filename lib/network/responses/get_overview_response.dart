import 'package:json_annotation/json_annotation.dart';
import 'package:library_app/data/vos/get_overview_result_vo.dart';

part 'get_overview_response.g.dart';

@JsonSerializable()
class GetOverviewResponse {
  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "copyright")
  String? copyright;

  @JsonKey(name: "num_results")
  int? numResults;

  @JsonKey(name: "results")
  GetOverviewResultVO? results;

  GetOverviewResponse(
    this.status,
    this.copyright,
    this.numResults,
    this.results,
  );

  factory GetOverviewResponse.fromJson(Map<String, dynamic> json) =>
      _$GetOverviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetOverviewResponseToJson(this);
}
