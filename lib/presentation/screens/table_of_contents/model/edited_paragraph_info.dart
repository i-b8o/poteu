import 'package:flutter/material.dart';

class EditedParagraphLink {
  final Color color;
  final String text;

  EditedParagraphLink({required this.color, required this.text});
}

class EditedParagraphInfo {
  final String regulationAbbriviation;
  final String chapterName;
  final int chapterID;
  final String content;
  final int paragraphID;
  final int lastTouched;
  final int? edited;
  final EditedParagraphLink link;

  EditedParagraphInfo({
    required this.regulationAbbriviation,
    required this.chapterName,
    required this.chapterID,
    required this.content,
    required this.paragraphID,
    required this.link,
    this.edited,
    required this.lastTouched,
  });
}
