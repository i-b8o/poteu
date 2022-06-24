import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'json_map.dart';

part 'edited.g.dart';

/// {@template edited}
/// A single edited item.
///
/// Contains a [chapterNum], [paragraphNum], [oldTextNum] and [newText]
///
/// [Edited]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class Edited extends Equatable {
  Edited({
    required int this.chapterNum,
    required int this.paragraphNum,
    required int this.oldTextNum,
    required String this.newText,
  });

  // The number of the chapter to edit
  final int chapterNum;
  // The number of the paragraph in the chapter to edit
  final int paragraphNum;
  // The index of the edited text in the paragraph to edit
  final int oldTextNum;
  // New text
  final String newText;

  /// Returns a copy of this edited with the given values updated.
  ///
  /// {@macro edited}
  Edited copyWith({
    int? chapterNum,
    int? paragraphNum,
    int? oldTextNum,
    String? newText,
  }) {
    return Edited(
      chapterNum: chapterNum ?? this.chapterNum,
      paragraphNum: paragraphNum ?? this.paragraphNum,
      oldTextNum: oldTextNum ?? this.oldTextNum,
      newText: newText ?? this.newText,
    );
  }

  /// Deserializes the given [JsonMap] into a [Edited].
  static Edited fromJson(JsonMap json) => _$EditedFromJson(json);

  /// Converts this [Edited] into a [JsonMap].
  JsonMap toJson() => _$EditedToJson(this);

  @override
  List<Object> get props => [
        chapterNum,
        paragraphNum,
        oldTextNum,
        newText,
      ];
}
