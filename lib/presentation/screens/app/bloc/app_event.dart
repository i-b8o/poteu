part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppThemeInitialEvent extends AppEvent {}

class AppSetThemeEvent extends AppEvent {
  final bool isDark;
  const AppSetThemeEvent(this.isDark);
  List<Object> get props => [isDark];
}
