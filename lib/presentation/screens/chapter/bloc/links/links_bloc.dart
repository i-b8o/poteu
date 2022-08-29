import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'links_event.dart';
part 'links_state.dart';

class LinksBloc extends Bloc<LinksEvent, LinksState> {
  LinksBloc() : super(LinksInitialState()) {
    on<EventLinkPressed>(_onEventLinkPressed);
  }

  void _onEventLinkPressed(EventLinkPressed event, Emitter<LinksState> emit) {
    emit(LinksLinkInState(event.index));
  }
}
