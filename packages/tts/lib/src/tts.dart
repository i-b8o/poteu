import 'package:flutter_tts/flutter_tts.dart';
import 'package:tts_api/tts_api.dart';

class TTS extends TTSApi {
  final FlutterTts _plugin;
  TTSSettings _ttsSettings =
      TTSSettings(pitch: 0.5, speechRate: 0.5, volume: 0.5, voice: "");

  TTS({required FlutterTts plugin}) : _plugin = plugin {
    _init();
  }

  _init() async {
    await _plugin.awaitSpeakCompletion(true);
  }

  @override
  Future<bool> checkRuLanguage() async {
    try {
      List<String>? languages = List<String>.from(await _plugin.getLanguages);
      if (!languages.contains("ru-RU")) {
        return false;
      }

      return true;
    } on Exception catch (_) {
      return false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<String>>? getVoices() async {
    List<String> _result = [];
    try {
      var voices = await _plugin.getVoices;
      for (var v in voices) {
        if (v['locale'] == "ru-RU") {
          _result.add(v['name'] ?? "");
        }
      }
      return _result;
    } on Exception catch (_) {
      return _result;
    } catch (_) {
      return _result;
    }
  }

  @override
  Future<bool> setVoice(String name) async {
    try {
      Map<String, String>? _voice;
      List voices = await _plugin.getVoices;
      for (var v in voices) {
        if (v['name'] == name) {
          _voice = {"name": name, "locale": v["locale"] ?? "ru-RU"};
        }
      }
      if (_voice == null) {
        return false;
      }
      _ttsSettings.voice = _voice["name"] ?? "";
      await _plugin.setVoice(_voice);
      return true;
    } on Exception catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future setPitch(double pitch) async {
    try {
      pitch = pitch * 1.5 + 0.5;
      _ttsSettings.pitch = pitch;
      await _plugin.setPitch(pitch);
    } on Exception catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future setSpeechRate(double rate) async {
    try {
      _ttsSettings.speechRate = rate;
      await _plugin.setSpeechRate(rate);
    } on Exception catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future setVolume(double volume) async {
    try {
      _ttsSettings.volume = volume;
      await _plugin.setVolume(volume);
    } on Exception catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future speak(String text) async {
    try {
      await _plugin.speak(text);
    } on Exception catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future stop() async {
    try {
      await _plugin.stop();
    } on Exception catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  TTSSettings getSettings() {
    return _ttsSettings;
  }
}
