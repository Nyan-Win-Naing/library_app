// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReviewVOAdapter extends TypeAdapter<ReviewVO> {
  @override
  final int typeId = 7;

  @override
  ReviewVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReviewVO(
      bookReviewLink: fields[0] as String?,
      firstChapterLink: fields[1] as String?,
      sundayReviewLink: fields[2] as String?,
      articleChapterLink: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ReviewVO obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.bookReviewLink)
      ..writeByte(1)
      ..write(obj.firstChapterLink)
      ..writeByte(2)
      ..write(obj.sundayReviewLink)
      ..writeByte(3)
      ..write(obj.articleChapterLink);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewVO _$ReviewVOFromJson(Map<String, dynamic> json) => ReviewVO(
      bookReviewLink: json['book_review_link'] as String?,
      firstChapterLink: json['first_chapter_link'] as String?,
      sundayReviewLink: json['sunday_review_link'] as String?,
      articleChapterLink: json['article_chapter_link'] as String?,
    );

Map<String, dynamic> _$ReviewVOToJson(ReviewVO instance) => <String, dynamic>{
      'book_review_link': instance.bookReviewLink,
      'first_chapter_link': instance.firstChapterLink,
      'sunday_review_link': instance.sundayReviewLink,
      'article_chapter_link': instance.articleChapterLink,
    };
