import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:regulation_api/regulation_api.dart';

import '../../../../../repository/regulation_repository.dart';

part 'table_of_contents_event.dart';
part 'table_of_contents_state.dart';

class TableOfContentsBloc
    extends Bloc<TableOfContentsEvent, TableOfContentsState> {
  TableOfContentsBloc({
    required RegulationRepository regulationRepository,
  })  : _regulationRepository = regulationRepository,
        super(TableOfContentsInitialState(
            title: regulationRepository.getRegulationAbbreviation(),
            name: regulationRepository.getRegulationName())) {
    on<TableOfContentsInitialEvent>(_onEventTableOfContentsInitial);
  }

  RegulationRepository _regulationRepository;

  String get regulationAbbreviation =>
      _regulationRepository.getRegulationAbbreviation();

  List<ChapterInfo> get chapters => _regulationRepository.getTableOfContents();

  String get regulationName => _regulationRepository.getRegulationName();

  void _onEventTableOfContentsInitial(
      TableOfContentsInitialEvent event, Emitter<TableOfContentsState> emit) {
    emit(TableOfContentsInitialState(
        title: regulationAbbreviation, name: regulationName));
  }
}
