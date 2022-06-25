// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doc.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DocAdapter extends TypeAdapter<Doc> {
  @override
  final int typeId = 4;

  @override
  Doc read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Doc(
      abbreviation: fields[0] as String,
      name: fields[1] as String,
      chapters: (fields[2] as List).cast<Chapter>(),
    );
  }

  @override
  void write(BinaryWriter writer, Doc obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.abbreviation)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.chapters);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doc _$DocFromJson(Map<String, dynamic> json) => Doc(
      abbreviation: json['abbreviation'] as String,
      name: json['name'] as String,
      chapters: (json['chapters'] as List<dynamic>)
          .map((e) => Chapter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DocToJson(Doc instance) => <String, dynamic>{
      'abbreviation': instance.abbreviation,
      'name': instance.name,
      'chapters': instance.chapters,
    };
