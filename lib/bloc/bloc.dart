import 'dart:convert';

import 'package:poteu/helper/data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Edited {
  final int chapterNum;
  final int paragraphNum;
  final int oldTextNum;
  final String newText;

  Edited(
      {required this.chapterNum,
      required this.paragraphNum,
      required this.oldTextNum,
      required this.newText});

  factory Edited.fromJson(Map<dynamic, dynamic> parsedJson) {
    return new Edited(
      chapterNum: parsedJson['chapterNum'] ?? "",
      paragraphNum: parsedJson['paragraphNum'] ?? "",
      oldTextNum: parsedJson['oldTextNum'] ?? "",
      newText: parsedJson['newText'] ?? "",
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      "chapterNum": this.chapterNum,
      "paragraphNum": this.paragraphNum,
      "oldTextNum": this.oldTextNum,
      "newText": this.newText,
    };
  }
}

class Bloc {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  List<String> _editedParagraphs = [];
  Bloc() {
    prefs.then((value) {
      if (value.get('edited') != null) {
        _editedParagraphs = value.getStringList('edited') ?? [];
        if (_editedParagraphs.length > 0) {
          for (var _ep in _editedParagraphs) {
            Map json = jsonDecode(_ep);
            var _edited = Edited.fromJson(json);
            editParagraphFromSP(_edited.chapterNum, _edited.paragraphNum,
                _edited.oldTextNum, _edited.newText);
          }
        }
      } else {
        _editedParagraphs = [];
      }
    });
  }
}
