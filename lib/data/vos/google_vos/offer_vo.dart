import 'package:json_annotation/json_annotation.dart';

part 'offer_vo.g.dart';

@JsonSerializable()
class OfferVO {
  @JsonKey(name: "finskyOfferType")
  int? finskyOfferType;

  OfferVO(this.finskyOfferType);

  factory OfferVO.fromJson(Map<String, dynamic> json) =>
      _$OfferVOFromJson(json);

  Map<String, dynamic> toJson() => _$OfferVOToJson(this);
}