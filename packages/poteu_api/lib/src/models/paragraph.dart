import 'package:poteu_api/src/models/table.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'json_map.dart';

part 'paragraph.g.dart';

// TODO Why chapter is string type?

/// {@template paragraph}
/// A single Paragraph item.
///
/// Contains a [chapter], [text] and [tables]
///
/// [Paragraph]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@HiveType(typeId: 2)
@JsonSerializable()
class Paragraph extends Equatable {
  // The number of the chapter containing the paragraph
  @HiveField(0)
  final String chapter;
  // The text of the paragraph
  @HiveField(1)
  final List<String> text;
  // The changed text of the paragraph
  @HiveField(2)
  final List<String> editedText;
  // The tables of the paragraph
  @HiveField(3)
  final List<ParagraphTable> tables;

  Paragraph(
      {required this.chapter,
      required this.text,
      required this.tables,
      this.editedText = const [""]});

  /// Returns a copy of this paragraph with the given values updated.
  ///
  /// {@macro paragraph}
  Paragraph copyWith({
    String? chapter,
    List<String>? text,
    List<ParagraphTable>? tables,
  }) {
    return Paragraph(
      chapter: chapter ?? this.chapter,
      text: text ?? this.text,
      tables: tables ?? this.tables,
    );
  }

  /// Deserializes the given [JsonMap] into a [Paragraph].
  static Paragraph fromJson(JsonMap json) => _$ParagraphFromJson(json);

  /// Converts this [Paragraph] into a [JsonMap].
  JsonMap toJson() => _$ParagraphToJson(this);

  @override
  List<Object> get props => [
        chapter,
        text,
        tables,
      ];
}
