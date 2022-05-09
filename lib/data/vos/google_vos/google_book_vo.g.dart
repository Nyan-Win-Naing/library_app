// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_book_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleBookVO _$GoogleBookVOFromJson(Map<String, dynamic> json) => GoogleBookVO(
      json['kind'] as String?,
      json['id'] as String?,
      json['etag'] as String?,
      json['selfLink'] as String?,
      json['volumeInfo'] == null
          ? null
          : VolumeInfoVO.fromJson(json['volumeInfo'] as Map<String, dynamic>),
      json['saleInfo'] == null
          ? null
          : SaleInfoVO.fromJson(json['saleInfo'] as Map<String, dynamic>),
      json['accessInfo'] == null
          ? null
          : AccessInfoVO.fromJson(json['accessInfo'] as Map<String, dynamic>),
      json['searchInfo'] == null
          ? null
          : SearchInfoVO.fromJson(json['searchInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GoogleBookVOToJson(GoogleBookVO instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'id': instance.id,
      'etag': instance.eTag,
      'selfLink': instance.selfLink,
      'volumeInfo': instance.volumeInfo,
      'saleInfo': instance.saleInfo,
      'accessInfo': instance.accessInfo,
      'searchInfo': instance.searchInfo,
    };
