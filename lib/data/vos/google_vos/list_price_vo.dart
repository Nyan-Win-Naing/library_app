import 'package:json_annotation/json_annotation.dart';

part 'list_price_vo.g.dart';

@JsonSerializable()
class ListPriceVO {
  @JsonKey(name: "amount")
  double? amount;

  @JsonKey(name: "currencyCode")
  String? currencyCode;

  ListPriceVO(this.amount, this.currencyCode);

  factory ListPriceVO.fromJson(Map<String, dynamic> json) =>
      _$ListPriceVOFromJson(json);

  Map<String, dynamic> toJson() => _$ListPriceVOToJson(this);
}