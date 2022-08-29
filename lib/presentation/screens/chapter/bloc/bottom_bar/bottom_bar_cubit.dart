import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';



part 'bottom_bar_state.dart';

class BottomBarCubit extends Cubit<bool> {
  BottomBarCubit() : super(false);

  void collapse() => emit(false);

  void expand() => emit(true);
}
