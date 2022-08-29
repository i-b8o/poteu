part of 'font_cubit.dart';

class FontState extends Equatable {
  const FontState({required this.fontSize, required this.fontWeight});
  final double fontSize;
  final double fontWeight;

  @override
  List<Object> get props => [fontSize, fontWeight];

  FontState copyWith({
    double? fontSize,
    double? fontWeight,
  }) {
    return FontState(
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
    );
  }
}
