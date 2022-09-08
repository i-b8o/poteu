import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../repository/regulation_repository.dart';
import '../../model/editable_content_paragraph.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({
    required RegulationRepository regulationRepository,
    required TextEditingController searchController,
  })  : _regulationRepository = regulationRepository,
        _searchController = searchController,
        super(SearchState([]));

  RegulationRepository _regulationRepository;
  TextEditingController _searchController;
  TextEditingController get searchController => _searchController;

  void search() {
    emit(SearchState(_regulationRepository.search(_searchController.text)));
  }
}
