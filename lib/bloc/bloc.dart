import 'dart:async';
import 'dart:convert';

import 'package:poteu/helper/data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:rxdart/rxdart.dart';

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

abstract class TTSEvent {}

class StartSpeechEvent extends TTSEvent {}

class StopSpeechEvent extends TTSEvent {}

class Bloc {
  bool _playing = false;

  final playingStateController = BehaviorSubject<bool>();
  // StreamSink<bool> get _inPlaying => _playingStateController.sink;
  // Stream<bool> get playing => _playingStateController.stream;
  // final _playingEventController = StreamController<TTSEvent>();
  // Sink<TTSEvent> get _playingEventSink => _playingEventController.sink;

  final FlutterTts flutterTts = FlutterTts();
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  List<String> _editedParagraphs = [];

  // flutterTts.setStartHandler(() {
  //   setState(() {
  //     isPlaying = true;
  //   });
  // });

  // flutterTts.setCompletionHandler(() {
  //   setState(() {
  //     isPlaying = false;
  //   });
  // });

  Future speak(String text) async {
    await flutterTts.setLanguage("ru-RU");
    var result = await flutterTts.speak(text);
    if (result == 1) _playing = true;
    print("RESULT: " + result);
    playingStateController.sink.add(_playing);
  }

  Future stop() async {
    flutterTts.stop();

    _playing = false;
    playingStateController.sink.add(_playing);
  }

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
    flutterTts.setStartHandler(() {
      print("START HANDLER");
      _playing = true;
      playingStateController.sink.add(_playing);
    });

    flutterTts.setCompletionHandler(() {
      print("COMPLITED HANDLER");
      _playing = false;
      playingStateController.sink.add(_playing);
    });
  }
  void dispose() {
    playingStateController.close();
  }
}
