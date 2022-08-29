import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:regulation_api/regulation_api.dart';

import '../../../../../repository/regulation_repository.dart';
import '../../../search/model/editable_content_paragraph.dart';

part 'table_of_contents_event.dart';
part 'table_of_contents_state.dart';

class TableOfContentsBloc
    extends Bloc<TableOfContentsEvent, TableOfContentsState> {
  TableOfContentsBloc(
      {required RegulationRepository regulationRepository,
      required TextEditingController searchController})
      : _regulationRepository = regulationRepository,
        _searchController = searchController,
        super(TableOfContentsInitialState(
            title: regulationRepository.getRegulationAbbreviation(),
            name: regulationRepository.getRegulationName())) {
    on<TableOfContentsInitialEvent>(_onEventTableOfContentsInitial);
    on<TableOfContentsSearchTextFieldActivatedEvent>(
        _onEventTableOfContentsSearchTextFieldActivated);
  }

  RegulationRepository _regulationRepository;
  TextEditingController _searchController;
  TextEditingController get searchController => _searchController;

  List<EditableContentParagraph> search() =>
      _regulationRepository.search(_searchController.text);

  String get regulationAbbreviation =>
      _regulationRepository.getRegulationAbbreviation();

  List<ChapterInfo> get chapters => _regulationRepository.getTableOfContents();

  String get regulationName => _regulationRepository.getRegulationName();

  void _onEventTableOfContentsInitial(
      TableOfContentsInitialEvent event, Emitter<TableOfContentsState> emit) {
    emit(TableOfContentsInitialState(
        title: regulationAbbreviation, name: regulationName));
  }

  void _onEventTableOfContentsSearchTextFieldActivated(
      TableOfContentsSearchTextFieldActivatedEvent event,
      Emitter<TableOfContentsState> emit) {
    emit(TableOfContentsSearchTextFieldActivatedState());
  }
}
