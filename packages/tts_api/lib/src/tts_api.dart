import '../tts_api.dart';

abstract class TTSApi {
  const TTSApi();

  Future<bool> checkRuLanguage();

  Future<List<String>>? getVoices();

  Future<bool> setVoice(String name);

  Future<void> setVolume(double volume);

  Future<void> setPitch(double pitch);

  Future<void> setSpeechRate(double rate);

  TTSSettings getSettings();

  Future<void> speak(String text);
  
  Future<void> stop();
}
