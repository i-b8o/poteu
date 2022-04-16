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
  // rate
  late double _rate; //0.0-1.0
  double get rate => _rate * 100;
  final __rateController = BehaviorSubject<double>();
  Stream<double> get rateStream => __rateController.stream;
  // pitch
  late double _pitch; //0.5-2.0
  double get pitch => (_pitch - 0.5) * 100 / 1.5;
  final __pitchController = BehaviorSubject<double>();
  Stream<double> get pitchStream => __pitchController.stream;

  final playingStateController = BehaviorSubject<bool>();

  final FlutterTts flutterTts = FlutterTts();
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  List<String> _editedParagraphs = [];

  Future increaseRate() async {
    if (_rate > 1.99) {
      return;
    }
    _rate = _rate + 0.01;
    await flutterTts.setSpeechRate(_rate);
    __rateController.sink.add(_rate);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('rate', _rate);
  }

  Future decreaseRate() async {
    if (_rate < 0.01) {
      return;
    }
    _rate = _rate - 0.01;
    await flutterTts.setSpeechRate(_rate);
    __rateController.sink.add(_rate);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('rate', _rate);
  }

  Future increasePitch() async {
    if (_pitch > 1.99) {
      return;
    }
    _pitch = _pitch + 0.01;
    await flutterTts.setPitch(_pitch);
    __pitchController.sink.add(_pitch);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('pitch', _pitch);
  }

  Future decreasePitch() async {
    if (_pitch < 0.51) {
      return;
    }
    _pitch = _pitch - 0.01;
    await flutterTts.setPitch(_pitch);
    __pitchController.sink.add(_pitch);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('pitch', _pitch);
  }

  Future speak(String text) async {
    await flutterTts.setLanguage("ru-RU");
    var result = await flutterTts.speak(text);
    if (result == 1) _playing = true;
    playingStateController.sink.add(_playing);
  }

  Future stop() async {
    flutterTts.stop();

    _playing = false;
    playingStateController.sink.add(_playing);
  }

  Bloc() {
    prefs.then((value) async {
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
      if (value.get('rate') != null) {
        _rate = value.getDouble('rate') ?? 0.5;
      } else {
        _rate = 0.5;
      }
      await flutterTts.setSpeechRate(_rate);
      if (value.get('pitch') != null) {
        _pitch = value.getDouble('pitch') ?? 0.5;
      } else {
        _pitch = 1.0;
      }
      await flutterTts.setPitch(_pitch);
    });

    flutterTts.setStartHandler(() {
      _playing = true;
      playingStateController.sink.add(_playing);
    });

    flutterTts.setCompletionHandler(() {
      _playing = false;
      playingStateController.sink.add(_playing);
    });
  }
  void dispose() {
    playingStateController.close();
  }
}
