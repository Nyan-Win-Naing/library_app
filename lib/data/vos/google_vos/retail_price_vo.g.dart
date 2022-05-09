// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retail_price_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetailPriceVO _$RetailPriceVOFromJson(Map<String, dynamic> json) =>
    RetailPriceVO(
      (json['amount'] as num?)?.toDouble(),
      json['currencyCode'] as String?,
    );

Map<String, dynamic> _$RetailPriceVOToJson(RetailPriceVO instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currencyCode': instance.currencyCode,
    };
