import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tts_api/tts_api.dart';

import 'package:poteu/repository/regulation_repository.dart';
import 'package:poteu/utils/patters.dart';
import 'package:poteu/presentation/screens/navigation_drawer/model/sound_settings.dart';

part 'sound_state.dart';

class SoundCubit extends Cubit<SoundState> {
  SoundCubit({required RegulationRepository regulationRepository})
      : _regulationRepository = regulationRepository,
        super(SoundState(
            volume: 0.5, speed: 0.5, pitch: 0.5, voice: '', speaking: false)) {
    _init();
  }

  final RegulationRepository _regulationRepository;
  List<String>? _voices;
  List<String>? get voices => _voices;

  _init() async {
    bool ru = await _regulationRepository.checkRuLanguage();
    if (!ru) {
      emit(SoundError('Отсутсвует русский язык'));
      return;
    }

    _voices = await _regulationRepository.getVoices();

    TTSSettings settings = await _regulationRepository.getSettings();
    double _volume = settings.volume;
    double _speed = settings.speechRate;
    double _pitch = settings.pitch;
    String _voice = settings.voice == ''
        ? _voices != null
            ? _voices![0]
            : ''
        : settings.voice;
    emit(SoundState(
        volume: _volume,
        speed: _speed,
        pitch: _pitch,
        voice: _voice,
        speaking: false));
  }

  Future<void> setSettings(SoundSettings settings) async {
    await stop();
    double _volume = settings.volume ?? state.volume;
    double _speed = settings.speed ?? state.speed;
    double _pitch = settings.pitch ?? state.pitch;
    String _voice = settings.voice ?? state.voice;

    emit(SoundState(
        volume: _volume,
        speed: _speed,
        pitch: _pitch,
        voice: _voice,
        speaking: false));
  }

  Future<void> speak(String text) async {
    if (state.speed == 0) {
      return;
    }
    emit(state.copyWith(speaking: true));
    await _regulationRepository.speak(text);
    emit(state.copyWith(speaking: false));
  }

  Future<void> speakRand() async {
    if (state.speed == 0) {
      return;
    }

    final _random = Random();

    int _randInt = _random.nextInt(PATTERS.length - 1);
    String text = PATTERS[_randInt];
    emit(state.copyWith(speaking: true));
    await _regulationRepository.speak(text);
    emit(state.copyWith(speaking: false));
  }

  Future<void> stop() async {
    await _regulationRepository.stop();
    emit(state.copyWith(speaking: false));
  }

  Future<void> saveVolume(double value) async =>
      await _regulationRepository.setVolume(value);

  Future<void> saveSpeed(double value) async =>
      await _regulationRepository.setSpeechRate(value);

  Future<void> savePitch(double value) async =>
      await _regulationRepository.setPitch(value);

  Future setVoice(String voice) async {
    setSettings(SoundSettings(voice: voice));
    await _regulationRepository.setVoice(voice);
  }
}
