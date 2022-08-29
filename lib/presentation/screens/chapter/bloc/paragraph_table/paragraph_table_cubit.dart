import 'package:bloc/bloc.dart';

class ParagraphTableCubit extends Cubit<bool> {
  ParagraphTableCubit(): super(true);

  void collapse() => emit(false);
  void expand() => emit(true);
}
