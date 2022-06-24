import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'json_map.dart';

part 'tts_settings.g.dart';

/// {@template ttsSettings}
/// A single ttsSettings item.
///
/// Contains a [rate]  and [pitch]
///
/// [TtsSettings]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class TtsSettings extends Equatable {
  TtsSettings({
    required this.rate,
    required this.pitch,
  });
  final double rate;
  final double pitch;

  /// Returns a copy of this ttsSettings with the given values updated.
  ///
  /// {@macro ttsSettings}
  TtsSettings copyWith({
    double? rate,
    double? pitch,
  }) {
    return TtsSettings(
      rate: rate ?? this.rate,
      pitch: pitch ?? this.pitch,
    );
  }

  /// Deserializes the given [JsonMap] into a [TtsSettings].
  static TtsSettings fromJson(JsonMap json) => _$TtsSettingsFromJson(json);

  /// Converts this [TtsSettings] into a [JsonMap].
  JsonMap toJson() => _$TtsSettingsToJson(this);

  @override
  List<Object> get props => [rate, pitch];
}
