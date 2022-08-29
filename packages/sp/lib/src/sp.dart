import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_api/sp_api.dart';

class SP extends SPApi {
  final SharedPreferences _plugin;

  static const THEME_KEY = 'theme_key';
  static const COLOR_PICKER_KEY = 'color_picker_key';
  static const ACTIVE_COLOR_INDEX_KEY = 'active_color_index_key';
  static const TTS_PITCH_KEY = 'tts_pitch_key';
  static const TTS_SPEECHRATE_KEY = 'tts_speechrate_key';
  static const TTS_VOLUME_KEY = 'tts_volume_key';
  static const TTS_VOICE_KEY = 'tts_voice_key';
  static const FONT_SIZE_KEY = 'font_size_key';
  static const FONT_WEIGHT_KEY = 'font_weight_key';

  SP({
    required SharedPreferences plugin,
  }) : _plugin = plugin;

  // Theme
  @override
  setTheme(bool value) async {
    try {
      await _plugin.setBool(THEME_KEY, value);
    } catch (e) {
      throw Exception('Cannot set Theme: $e');
    }
  }

  @override
  bool? getTheme() {
    try {
      return _plugin.getBool(THEME_KEY) ?? false;
    } catch (e) {
      throw Exception('Theme not found: $e');
    }
  }

// Colors
  @override
  setColorPickerColors(List<int> colors) async {
    List<String> _colorsStringList = [];
    try {
      for (final _color in colors) {
        _colorsStringList.add(_color.toString());
      }
      await _plugin.setStringList(COLOR_PICKER_KEY, _colorsStringList);
    } catch (e) {
      throw Exception('Cannot set colors: $e');
    }
  }

  @override
  List<String>? getColorPickerColors() {
    try {
      return _plugin.getStringList(COLOR_PICKER_KEY);
    } catch (e) {
      throw Exception('Colors not found: $e');
    }
  }

  setActiveColorIndex(int index) async {
    try {
      await _plugin.setInt(ACTIVE_COLOR_INDEX_KEY, index);
    } catch (e) {
      throw Exception('Cannot set ACTIVE_COLOR_INDEX: $e');
    }
  }

  int? getActiveColorIndex() {
    try {
      return _plugin.getInt(ACTIVE_COLOR_INDEX_KEY);
    } catch (e) {
      throw Exception('Cannot set ACTIVE_COLOR_INDEX: $e');
    }
  }

  @override
  bool colorPickerConfigured() {
    try {
      return _plugin.containsKey(COLOR_PICKER_KEY);
    } catch (e) {
      throw Exception('Colors not found: $e');
    }
  }

// TTS
  @override
  double? getPitch() {
    try {
      return _plugin.getDouble(TTS_PITCH_KEY);
    } catch (e) {
      throw Exception('Pitch not found: $e');
    }
  }

  @override
  double? getSpeechRate() {
    try {
      return _plugin.getDouble(TTS_SPEECHRATE_KEY);
    } catch (e) {
      throw Exception('Speech rate not found: $e');
    }
  }

  @override
  String? getVoice() {
    try {
      return _plugin.getString(TTS_VOICE_KEY);
    } catch (e) {
      throw Exception('Voice not found: $e');
    }
  }

  @override
  double? getVolume() {
    try {
      return _plugin.getDouble(TTS_VOLUME_KEY);
    } catch (e) {
      throw Exception('Volume not found: $e');
    }
  }

  @override
  Future setPitch(double pitch) async {
    try {
      await _plugin.setDouble(TTS_PITCH_KEY, pitch);
    } catch (e) {
      throw Exception('Cannot set pitch: $e');
    }
  }

  @override
  Future setSpeechRate(double speechrate) async {
    try {
      await _plugin.setDouble(TTS_SPEECHRATE_KEY, speechrate);
    } catch (e) {
      throw Exception('Cannot set speech rate: $e');
    }
  }

  @override
  Future setVoice(String voice) async {
    try {
      await _plugin.setString(TTS_VOICE_KEY, voice);
    } catch (e) {
      throw Exception('Cannot set speech rate: $e');
    }
  }

  @override
  Future setVolume(double volume) async {
    try {
      await _plugin.setDouble(TTS_VOLUME_KEY, volume);
    } catch (e) {
      throw Exception('Cannot set speech rate: $e');
    }
  }

// Font
  @override
  Future setFontSize(double fontSize) async {
    try {
      await _plugin.setDouble(FONT_SIZE_KEY, fontSize);
    } catch (e) {
      throw Exception('Cannot set font size: $e');
    }
  }

  @override
  double? getFontSize() {
    try {
      return _plugin.getDouble(FONT_SIZE_KEY);
    } catch (e) {
      throw Exception('Font size not found: $e');
    }
  }

  @override
  Future setFontWeight(double fontWeight) async {
    try {
      await _plugin.setDouble(FONT_WEIGHT_KEY, fontWeight);
    } catch (e) {
      throw Exception('Cannot set font weight: $e');
    }
  }

  @override
  double? getFontWeight() {
    try {
      return _plugin.getDouble(FONT_WEIGHT_KEY);
    } catch (e) {
      throw Exception('Font weight not found: $e');
    }
  }

  resetFont() async {
    await _plugin.remove(FONT_SIZE_KEY);
    await _plugin.remove(FONT_WEIGHT_KEY);
  }
}
