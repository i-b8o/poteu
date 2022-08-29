class TTSSettings {
  double pitch;
  double speechRate;
  double volume;
  String voice;
  TTSSettings({
    required this.pitch,
    required this.speechRate,
    required this.volume,
    required this.voice,
  });
  TTSSettings copyWith({
    double? pitch,
    double? speechRate,
    double? volume,
    String? voice,
  }) {
    return TTSSettings(
        pitch: pitch ?? this.pitch,
        speechRate: speechRate ?? this.speechRate,
        volume: volume ?? this.volume,
        voice: voice ?? this.voice, 
        );
  }
}
