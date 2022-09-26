import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:poteu/repository/regulation_repository.dart';

part 'colors_state.dart';

class ColorsCubit extends Cubit<ColorsState> {
  ColorsCubit({required RegulationRepository regulationRepository})
      : _regulationRepository = regulationRepository,
        super(ColorsState(
          colorsList: regulationRepository.getColorPickerColors(),
          activeIndex: regulationRepository.getActiveColorIndex(),
          activeColor: regulationRepository.getActiveColor(),
        )) {
    if (!_regulationRepository.colorPickerKeyExist()) {
      return;
    }
  }

  final RegulationRepository _regulationRepository;

  save(bool yes) async =>
      await _regulationRepository.setColorPickerColors(state.colorsList);

  Future<void> setActiveIndex(int index) async {
    await _regulationRepository.setActiveColorIndex(index);

    emit(state.copyWith(
      colorsList: state.colorsList,
      activeIndex: index,
    ));
  }

  void setColor(int color) {
    List<int> newColorsList = List<int>.from(state.colorsList);
    newColorsList[state.activeIndex] = color;
    emit(state.copyWith(colorsList: newColorsList, activeColor: color));
  }

  int getActiveColor() {
    List<int> _colors = state.colorsList;
    int _activeIndex = state.activeIndex;
    return _colors[_activeIndex];
  }

  void addColor() {
    List<int> newColorsList = List<int>.from(state.colorsList);
    newColorsList..add(0xFF525965);
    emit(state.copyWith(
      colorsList: newColorsList,
      activeIndex: state.colorsList.length - 1,
    ));
  }

  void deleteColor(int index) {
    emit(state.copyWith(
      colorsList: state.colorsList..removeAt(index),
      activeIndex: state.colorsList.length - 1,
    ));
  }
}
