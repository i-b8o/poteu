import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:poteu/repository/regulation_repository.dart';
import 'package:poteu/presentation/screens/search/model/editable_content_paragraph.dart';

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
  List<String> _searchQueries = [];
  int _searchQueriesIndex = 0;

  void search() {
    int _index = ++_searchQueriesIndex;
    _searchQueries.add(_searchController.text);
    Timer(Duration(seconds: 1), () {
      if (_index == _searchQueriesIndex) {
        _searchQueriesIndex = 0;
        emit(SearchState(_regulationRepository.search(_searchQueries.last)));
      }
    });
  }
}
