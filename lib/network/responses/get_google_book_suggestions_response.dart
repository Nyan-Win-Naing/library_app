import 'package:json_annotation/json_annotation.dart';
import 'package:library_app/data/vos/google_vos/google_book_vo.dart';

part 'get_google_book_suggestions_response.g.dart';

@JsonSerializable()
class GetGoogleBookSuggestionsResponse {
  @JsonKey(name: "kind")
  String? kind;

  @JsonKey(name: "totalItems")
  int? totalItems;

  @JsonKey(name: "items")
  List<GoogleBookVO>? items;

  GetGoogleBookSuggestionsResponse(this.kind, this.totalItems, this.items);

  factory GetGoogleBookSuggestionsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetGoogleBookSuggestionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetGoogleBookSuggestionsResponseToJson(this);
}