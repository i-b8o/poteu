import 'models/models.dart';

abstract class PoteuApi {
  const PoteuApi();

  /// Provides a [Stream] of all edited paragraphs for the document.
  Stream<List<Edited>> getEdited();

  /// Saves a [edited].
  ///
  /// If a [edited] with the same id already exists, it will be replaced.
  Future<void> saveEdited(Edited edited);

  /// Provides a settings for TTS.
  Future<TtsSettings> getTTSSettings();

  /// Saves a [TTSSettings].
  Future<void> saveTTSSettings(TtsSettings settings);
}
