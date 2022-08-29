part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {
  const AppInitial();
  @override
  List<Object> get props => [];
}

class AppThemeState extends AppState {
  final bool isDark;

  const AppThemeState(this.isDark);

  List<Object> get props => [isDark];
}
