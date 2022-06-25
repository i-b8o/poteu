// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParagraphTableAdapter extends TypeAdapter<ParagraphTable> {
  @override
  final int typeId = 1;

  @override
  ParagraphTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParagraphTable(
      name: fields[0] as String,
      num: fields[1] as String,
      img: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ParagraphTable obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.num)
      ..writeByte(2)
      ..write(obj.img);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParagraphTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParagraphTable _$ParagraphTableFromJson(Map<String, dynamic> json) =>
    ParagraphTable(
      name: json['name'] as String,
      num: json['num'] as String,
      img: json['img'] as String,
    );

Map<String, dynamic> _$ParagraphTableToJson(ParagraphTable instance) =>
    <String, dynamic>{
      'name': instance.name,
      'num': instance.num,
      'img': instance.img,
    };
