// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_overview_result_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetOverviewResultVOAdapter extends TypeAdapter<GetOverviewResultVO> {
  @override
  final int typeId = 3;

  @override
  GetOverviewResultVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetOverviewResultVO(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
      (fields[5] as List?)?.cast<HorizontalBookListItemVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, GetOverviewResultVO obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.bestsellersDate)
      ..writeByte(1)
      ..write(obj.publishedDate)
      ..writeByte(2)
      ..write(obj.publishedDateDescription)
      ..writeByte(3)
      ..write(obj.previousPublishedDate)
      ..writeByte(4)
      ..write(obj.nextPublishedDate)
      ..writeByte(5)
      ..write(obj.lists);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetOverviewResultVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOverviewResultVO _$GetOverviewResultVOFromJson(Map<String, dynamic> json) =>
    GetOverviewResultVO(
      json['bestsellers_date'] as String?,
      json['published_date'] as String?,
      json['published_date_description'] as String?,
      json['previous_published_date'] as String?,
      json['next_published_date'] as String?,
      (json['lists'] as List<dynamic>?)
          ?.map((e) =>
              HorizontalBookListItemVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetOverviewResultVOToJson(
        GetOverviewResultVO instance) =>
    <String, dynamic>{
      'bestsellers_date': instance.bestsellersDate,
      'published_date': instance.publishedDate,
      'published_date_description': instance.publishedDateDescription,
      'previous_published_date': instance.previousPublishedDate,
      'next_published_date': instance.nextPublishedDate,
      'lists': instance.lists,
    };
