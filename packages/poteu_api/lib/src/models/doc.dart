import 'package:poteu_api/src/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'json_map.dart';

part 'doc.g.dart';

/// {@template document}
/// A single Document item.
///
/// Contains a [chapters]
///
/// [Doc]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@HiveType(typeId: 4)
@JsonSerializable()
class Doc extends Equatable {
  // The abbreviation of the document
  @HiveField(0)
  final String abbreviation;
  // The name of the document
  @HiveField(1)
  final String name;
  // The list of chapters
  @HiveField(2)
  final List<Chapter> chapters;

  Doc({required this.abbreviation, required this.name, required this.chapters});

  /// Returns a copy of this document with the given values updated.
  ///
  /// {@macro document}
  Doc copyWith({
    String? abbreviation,
    String? name,
    List<Chapter>? chapters,
  }) {
    return Doc(
      abbreviation: abbreviation ?? this.abbreviation,
      name: name ?? this.name,
      chapters: chapters ?? this.chapters,
    );
  }

  /// Deserializes the given [JsonMap] into a [Doc].
  static Doc fromJson(JsonMap json) => _$DocFromJson(json);

  /// Converts this [Doc] into a [JsonMap].
  JsonMap toJson() => _$DocToJson(this);

  @override
  List<Object> get props => [
        chapters,
      ];
}
