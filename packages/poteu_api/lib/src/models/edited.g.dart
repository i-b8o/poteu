// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edited.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Edited _$EditedFromJson(Map<String, dynamic> json) => Edited(
      chapterNum: json['chapterNum'] as int,
      paragraphNum: json['paragraphNum'] as int,
      oldTextNum: json['oldTextNum'] as int,
      newText: json['newText'] as String,
    );

Map<String, dynamic> _$EditedToJson(Edited instance) => <String, dynamic>{
      'chapterNum': instance.chapterNum,
      'paragraphNum': instance.paragraphNum,
      'oldTextNum': instance.oldTextNum,
      'newText': instance.newText,
    };
