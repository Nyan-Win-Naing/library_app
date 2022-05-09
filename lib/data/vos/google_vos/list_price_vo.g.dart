// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_price_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListPriceVO _$ListPriceVOFromJson(Map<String, dynamic> json) => ListPriceVO(
      (json['amount'] as num?)?.toDouble(),
      json['currencyCode'] as String?,
    );

Map<String, dynamic> _$ListPriceVOToJson(ListPriceVO instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currencyCode': instance.currencyCode,
    };
