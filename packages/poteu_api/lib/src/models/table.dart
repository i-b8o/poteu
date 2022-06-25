import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'json_map.dart';

part 'table.g.dart';

/// {@template paragraphTable}
/// A single ParagraphTable item.
///
/// Contains a [name], [num] and [img]
///
/// [ParagraphTable]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@HiveType(typeId: 1)
@JsonSerializable()
class ParagraphTable extends Equatable {
  // The name of the table
  @HiveField(0)
  final String name;
  // The order num of the table
  @HiveField(1)
  final String num;
  // The img src of the table
  @HiveField(2)
  final String img;

  ParagraphTable({required this.name, required this.num, required this.img});

  /// Returns a copy of this table with the given values updated.
  ///
  /// {@macro paragraphtable}
  ParagraphTable copyWith({
    String? name,
    String? num,
    String? img,
  }) {
    return ParagraphTable(
      name: name ?? this.name,
      num: num ?? this.num,
      img: img ?? this.img,
    );
  }

  /// Deserializes the given [JsonMap] into a [ParagraphTable].
  static ParagraphTable fromJson(JsonMap json) =>
      _$ParagraphTableFromJson(json);

  /// Converts this [ParagraphTable] into a [JsonMap].
  JsonMap toJson() => _$ParagraphTableToJson(this);
  @override
  List<Object> get props => [
        name,
        num,
        img,
      ];
}
