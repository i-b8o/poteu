// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paragraph.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParagraphAdapter extends TypeAdapter<Paragraph> {
  @override
  final int typeId = 2;

  @override
  Paragraph read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Paragraph(
      chapter: fields[0] as String,
      text: (fields[1] as List).cast<String>(),
      tables: (fields[3] as List).cast<ParagraphTable>(),
      editedText: (fields[2] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Paragraph obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.chapter)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.editedText)
      ..writeByte(3)
      ..write(obj.tables);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParagraphAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paragraph _$ParagraphFromJson(Map<String, dynamic> json) => Paragraph(
      chapter: json['chapter'] as String,
      text: (json['text'] as List<dynamic>).map((e) => e as String).toList(),
      tables: (json['tables'] as List<dynamic>)
          .map((e) => ParagraphTable.fromJson(e as Map<String, dynamic>))
          .toList(),
      editedText: (json['editedText'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [""],
    );

Map<String, dynamic> _$ParagraphToJson(Paragraph instance) => <String, dynamic>{
      'chapter': instance.chapter,
      'text': instance.text,
      'editedText': instance.editedText,
      'tables': instance.tables,
    };
