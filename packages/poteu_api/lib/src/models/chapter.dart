import 'package:poteu_api/src/models/paragraph.dart';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'json_map.dart';

part 'chapter.g.dart';

/// {@template chapter}
/// A single Chapter item.
///
/// Contains a [name], [num] and [paragraphs]
///
/// [Chapter]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@HiveType(typeId: 3)
@JsonSerializable()
class Chapter extends Equatable {
  // The name of the chapter
  @HiveField(0)
  final String name;
  // The number of the chapter
  @HiveField(1)
  final String num;
  // Paragraphs of the chapter
  @HiveField(2)
  final List<Paragraph> paragraphs;

  Chapter({required this.num, required this.name, required this.paragraphs});

  /// Returns a copy of this chapter with the given values updated.
  ///
  /// {@macro chapter}
  Chapter copyWith({
    String? name,
    String? num,
    List<Paragraph>? paragraphs,
  }) {
    return Chapter(
      name: name ?? this.name,
      num: num ?? this.num,
      paragraphs: paragraphs ?? this.paragraphs,
    );
  }

  /// Deserializes the given [JsonMap] into a [Chapter].
  static Chapter fromJson(JsonMap json) => _$ChapterFromJson(json);

  /// Converts this [Chapter] into a [JsonMap].
  JsonMap toJson() => _$ChapterToJson(this);

  @override
  List<Object> get props => [
        name,
        num,
        paragraphs,
      ];
}
