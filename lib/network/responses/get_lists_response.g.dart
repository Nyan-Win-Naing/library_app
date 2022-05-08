// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_lists_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListsResponse _$GetListsResponseFromJson(Map<String, dynamic> json) =>
    GetListsResponse(
      json['status'] as String?,
      json['copyright'] as String?,
      json['num_results'] as int?,
      json['last_modified'] as String?,
      (json['results'] as List<dynamic>?)
          ?.map((e) => MoreBookListItemVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetListsResponseToJson(GetListsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'copyright': instance.copyright,
      'num_results': instance.numResults,
      'last_modified': instance.lastModified,
      'results': instance.results,
    };
