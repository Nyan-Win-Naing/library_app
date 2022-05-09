import 'package:json_annotation/json_annotation.dart';

part 'retail_price_vo.g.dart';

@JsonSerializable()
class RetailPriceVO {
  @JsonKey(name: "amount")
  double? amount;

  @JsonKey(name: "currencyCode")
  String? currencyCode;

  RetailPriceVO(this.amount, this.currencyCode);

  factory RetailPriceVO.fromJson(Map<String, dynamic> json) =>
      _$RetailPriceVOFromJson(json);

  Map<String, dynamic> toJson() => _$RetailPriceVOToJson(this);
}