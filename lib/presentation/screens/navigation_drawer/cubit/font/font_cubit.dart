import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../repository/regulation_repository.dart';

part 'font_state.dart';

class FontCubit extends Cubit<FontState> {
  FontCubit({required RegulationRepository regulationRepository})
      : _regulationRepository = regulationRepository,
        super(FontState(fontSize: 0.1, fontWeight: 0.1)) {
    _init();
  }
  final RegulationRepository _regulationRepository;
  _init() async {
    final double _fontSize = await _regulationRepository.getFontSize();
    final double _fontWeight = await _regulationRepository.getFontWeight();

    emit(FontState(fontSize: _fontSize, fontWeight: _fontWeight));
  }

  void setFontSize(double fontSize) {
    emit(state.copyWith(fontSize: fontSize));
  }

  void setFontWeight(double fontWeight) {
    emit(state.copyWith(fontWeight: fontWeight));
  }

  Future<void> saveFontSize(double value) async =>
      await _regulationRepository.setFontSize(value);
  Future<void> saveFontWeight(double value) async =>
      await _regulationRepository.setFontWeight(value);

  Future<void> resetFont() async {
    await _regulationRepository.resetFont();
    final double _fontSize = await _regulationRepository.getFontSize();
    final double _fontWeight = await _regulationRepository.getFontWeight();

    emit(FontState(fontSize: _fontSize, fontWeight: _fontWeight));
  }
}
