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
          activeColor: 0xFF8963ff,
        )) {
    if (!_regulationRepository.colorPickerKeyExist()) {
      return;
    }
    emit(state.copyWith(activeColor: state.colorsList[state.activeIndex]));
  }

  final RegulationRepository _regulationRepository;

  save(bool yes) async =>
      await _regulationRepository.setColorPickerColors(state.colorsList);

  Future<void> setActiveIndex(int index) async {
    await _regulationRepository.setActiveColorIndex(index);

    emit(state.copyWith(
      colorsList: state.colorsList,
      activeIndex: index,
      activeColor: state.colorsList[index],
    ));
  }

  void setColor(int color) {
    state.colorsList[state.activeIndex] = color;
    emit(state.copyWith(
      colorsList: state.colorsList,
      activeColor: color,
    ));
  }

  int getActiveColor() {
    return state.activeColor;
  }

  void addColor() {
    List<int> newColorsList = state.colorsList;
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
