// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_google_book_suggestions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGoogleBookSuggestionsResponse _$GetGoogleBookSuggestionsResponseFromJson(
        Map<String, dynamic> json) =>
    GetGoogleBookSuggestionsResponse(
      json['kind'] as String?,
      json['totalItems'] as int?,
      (json['items'] as List<dynamic>?)
          ?.map((e) => GoogleBookVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetGoogleBookSuggestionsResponseToJson(
        GetGoogleBookSuggestionsResponse instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'totalItems': instance.totalItems,
      'items': instance.items,
    };
