import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:poteu/repository/regulation_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required RegulationRepository regulationRepository})
      : _regulationRepository = regulationRepository,
        super(AppInitial()) {
    on<AppThemeInitialEvent>((event, emit) async {
      emit(AppInitial());
      await getTheme();
      emit(AppThemeState(_isDark));
    });

    on<AppSetThemeEvent>((event, emit) {
      isDark = event.isDark;
      emit(AppThemeState(_isDark));
    });
  }
  final RegulationRepository _regulationRepository;

  bool _isDark = false;
  bool get isDark => _isDark;

  getTheme() async {
    _isDark = await _regulationRepository.getTheme();
  }

  set isDark(bool value) {
    _isDark = value;
    _regulationRepository.setTheme(value);
  }
}
