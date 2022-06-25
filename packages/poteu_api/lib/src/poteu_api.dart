import 'models/models.dart';

abstract class PoteuApi {
  const PoteuApi();

  /// Provides a [Doc].
  Future<Doc> getDoc(String abbreviation);

  /// Saves a [Doc].
  ///
  /// If a [Doc] with the same name already exists, it will be replaced.
  Future<void> saveDoc(Doc document);

  // /// Provides a settings for TTS.
  // Future<TtsSettings> getTTSSettings();

  // /// Saves a [TTSSettings].
  // Future<void> saveTTSSettings(TtsSettings settings);
}
