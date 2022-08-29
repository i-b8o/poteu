part of 'sound_cubit.dart';

class SoundState extends Equatable {
  const SoundState({
    required this.speed,
    required this.volume,
    required this.pitch,
    required this.voice,
    required this.speaking,
  });
  final double volume;
  final double speed;
  final double pitch;
  final String voice;
  final bool speaking;
  @override
  List<Object> get props => [volume, speed, pitch, voice, speaking];

  SoundState copyWith({
    double? volume,
    double? speed,
    double? pitch,
    String? voice,
    bool? speaking,
  }) {
    return SoundState(
      volume: volume ?? this.volume,
      speed: speed ?? this.speed,
      pitch: pitch ?? this.pitch,
      voice: voice ?? this.voice,
      speaking: speaking ?? this.speaking,
    );
  }
}

class SoundError extends SoundState {
  final String message;
  SoundError(this.message)
      : super(speed: 0.6, volume: 0.6, pitch: 0.6, voice: '', speaking: false);
}
