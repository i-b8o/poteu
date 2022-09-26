import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:regulation_api/regulation_api.dart';

import 'package:poteu/repository/regulation_repository.dart';

part 'event.dart';
part 'state.dart';

class PageViewBloc extends Bloc<PageViewEvent, PageViewInitState> {
  PageViewBloc(
      {required RegulationRepository regulationRepository,
      required int totalChapters,
      required PageController pageController,
      required TextEditingController appBarOrderNumController,
      required int chapterOrderNum,
      required int paragraphOrderNum})
      : _regulationRepository = regulationRepository,
        _pageController = pageController,
        _appBarOrderNumController = appBarOrderNumController,
        _totalChapters = totalChapters,
        _chapterOrderNum = chapterOrderNum,
        super(PageViewInitState(changed: false)) {
    on<PageViewLoadParagraphsEvent>(_onLoadParagraphsEvent);
    on<PageViewChapterChangedEvent>(_onEventChapterPageChanged);
    on<PageViewParagraphSavedEvent>(_onEventParagraphSavedEvent);
  }

  final RegulationRepository _regulationRepository;
  final PageController _pageController;
  final TextEditingController _appBarOrderNumController;
  final int _totalChapters;
  int _chapterOrderNum;
  bool changed = false;

  int get totalChapters => _totalChapters;
  int get chapterOrderNum => _chapterOrderNum;

  // Future<List<EditableParagraph>> paragraphs(int chapterOrderNum) =>
  //     _regulationRepository.getParagraphsByChapterOrderNum(chapterOrderNum);

  // String chapterNameByOrderNum(int chapterOrderNum) =>
  //     _regulationRepository.getChapterNameByOrderNum(chapterOrderNum);

  GoTo? goTo(int? chapterID, paragraphID) =>
      _regulationRepository.getGoTo(chapterID, paragraphID);

  Future<List<String>> paragraphsContent() async {
    List<EditableParagraph> _editableParagraphs = await _regulationRepository
        .getParagraphsByChapterOrderNum(_chapterOrderNum);
    List<String> _textSpeechList = [];
    for (EditableParagraph ep in _editableParagraphs.toList()) {
      _textSpeechList += ep.textToSpeech;
    }
    return _textSpeechList;
  }

  set setAppBarOrderNumText(int num) {
    try {
      _appBarOrderNumController.text = num.toString();
    } catch (e) {}
  }

  Future<void> _onLoadParagraphsEvent(PageViewLoadParagraphsEvent event,
      Emitter<PageViewInitState> emit) async {
    // String _chapterName =
    //     _regulationRepository.getChapterNameByOrderNum(_chapterOrderNum);
    // List<EditableParagraph> _paragraphs = await _regulationRepository
    //     .getParagraphsByChapterOrderNum(_chapterOrderNum);

    changed = !changed;
    emit(PageViewChapterLoadedState(
        changed: changed,
        appBarOrderNumController: _appBarOrderNumController,
        pageController: _pageController,
        chapterName:
            _regulationRepository.getChapterNameByOrderNum(_chapterOrderNum),
        chapterOrderNum: _chapterOrderNum,
        paragraphOrderNum: event.paragraphOrderNum,
        paragraphs: await _regulationRepository
            .getParagraphsByChapterOrderNum(_chapterOrderNum),
        totalChapters: _totalChapters));
  }

  Future<void> _onEventChapterPageChanged(PageViewChapterChangedEvent event,
      Emitter<PageViewInitState> emit) async {
    setAppBarOrderNumText = event.chapterOrderNum;
    _chapterOrderNum = event.chapterOrderNum;

    changed = !changed;
    emit(PageViewChapterLoadedState(
      changed: changed,
      paragraphs: await _regulationRepository
          .getParagraphsByChapterOrderNum(event.chapterOrderNum),
      chapterOrderNum: event.chapterOrderNum,
      appBarOrderNumController: _appBarOrderNumController,
      pageController: _pageController,
      chapterName:
          _regulationRepository.getChapterNameByOrderNum(event.chapterOrderNum),
      totalChapters: _totalChapters,
      paragraphOrderNum: 0,
    ));
  }

  Future<void> _onEventParagraphSavedEvent(PageViewParagraphSavedEvent event,
      Emitter<PageViewInitState> emit) async {
    changed = !changed;
    emit(PageViewChapterLoadedState(
      changed: changed,
      paragraphs: await _regulationRepository
          .getParagraphsByChapterOrderNum(_chapterOrderNum),
      chapterOrderNum: _chapterOrderNum,
      appBarOrderNumController: _appBarOrderNumController,
      pageController: _pageController,
      chapterName:
          _regulationRepository.getChapterNameByOrderNum(_chapterOrderNum),
      totalChapters: _totalChapters,
      paragraphOrderNum: event.paragraphOrderNum,
    ));
  }
}
