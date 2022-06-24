// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tts_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TtsSettings _$TtsSettingsFromJson(Map<String, dynamic> json) => TtsSettings(
      rate: (json['rate'] as num).toDouble(),
      pitch: (json['pitch'] as num).toDouble(),
    );

Map<String, dynamic> _$TtsSettingsToJson(TtsSettings instance) =>
    <String, dynamic>{
      'rate': instance.rate,
      'pitch': instance.pitch,
    };
