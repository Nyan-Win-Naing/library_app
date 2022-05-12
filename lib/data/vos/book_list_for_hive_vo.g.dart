// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_list_for_hive_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookListForHiveVOAdapter extends TypeAdapter<BookListForHiveVO> {
  @override
  final int typeId = 8;

  @override
  BookListForHiveVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookListForHiveVO(
      bookList: (fields[0] as List?)?.cast<BookVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, BookListForHiveVO obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.bookList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookListForHiveVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
