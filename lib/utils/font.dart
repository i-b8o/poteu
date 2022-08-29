double realFontSize(double fontSize) {
  return fontSize * 15 + 15;
}

int fontWeightIndex(double fontWeight) {
  int _fontWeightIndex = (fontWeight * 8).round().toInt();
  return _fontWeightIndex > 8 ? 8 : _fontWeightIndex;
}
