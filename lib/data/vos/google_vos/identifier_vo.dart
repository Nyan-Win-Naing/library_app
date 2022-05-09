import 'package:json_annotation/json_annotation.dart';

part 'identifier_vo.g.dart';

@JsonSerializable()
class IdentifierVO {
  @JsonKey(name: "type")
  String? type;

  @JsonKey(name: "identifier")
  String? identifier;

  IdentifierVO(this.type, this.identifier);

  factory IdentifierVO.fromJson(Map<String, dynamic> json) =>
      _$IdentifierVOFromJson(json);

  Map<String, dynamic> toJson() => _$IdentifierVOToJson(this);
}