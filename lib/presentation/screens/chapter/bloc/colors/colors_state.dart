part of 'colors_cubit.dart';

class ColorsState extends Equatable {
  final List<int> colorsList;
  final int activeIndex;
  final int activeColor;

  ColorsState({
    required this.colorsList,
    required this.activeIndex,
    required this.activeColor,
  });

  ColorsState copyWith({
    bool? quit,
    List<int>? colorsList,
    int? activeIndex,
    int? activeColor,
  }) {
    return ColorsState(
        colorsList: colorsList ?? this.colorsList,
        activeIndex: activeIndex ?? this.activeIndex,
        activeColor: activeColor ?? this.activeColor);
  }

  @override
  List<Object> get props => [colorsList, activeIndex, activeColor];
}
