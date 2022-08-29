abstract class SPApi {
  const SPApi();
// Theme
  setTheme(bool value);
  bool? getTheme();
// Colors
  setColorPickerColors(List<int> colors);
  bool colorPickerConfigured();
  List<String>? getColorPickerColors();
  setActiveColorIndex(int index);
  int? getActiveColorIndex();
// TTS
  Future setPitch(double pitch);
  double? getPitch();
  Future setSpeechRate(double speechrate);
  double? getSpeechRate();
  Future setVolume(double volume);
  double? getVolume();
  Future setVoice(String voice);
  String? getVoice();
// Font
  Future setFontSize(double fontSize);
  double? getFontSize();
  Future setFontWeight(double fontWeight);
  double? getFontWeight();
  resetFont();
}
