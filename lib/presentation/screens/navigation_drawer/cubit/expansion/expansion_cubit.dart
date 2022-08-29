import 'package:bloc/bloc.dart';

class ExpansionCubit extends Cubit<int> {
  ExpansionCubit() : super(-1);
  void setSelected(int i) => emit(i);
}
