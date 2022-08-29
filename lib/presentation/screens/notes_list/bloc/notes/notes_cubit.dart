import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:sqlite_api/sqlite_api.dart';

import '../../../../../repository/regulation_repository.dart';
import '../../../../../utils/text.dart';
import '../../../table_of_contents/model/edited_paragraph_info.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit({required RegulationRepository regulationRepository})
      : _regulationRepository = regulationRepository,
        super(NotesInitial()) {
    getEditedParagraphs(false).then((editedParagraphs) {
      _editedParagraphsInfo = editedParagraphs;
      List<Color> _colors = [];

      emit(NotesLoaded(
        colors: _colors,
        editedParagraphs: _editedParagraphsInfo,
      ));
    });
  }

  List<int> getChapterAndParagraphOrderNums(int chapterID, paragraphID) =>
      _regulationRepository.getChapterAndParagraphOrderNums(
          chapterID, paragraphID);

  final RegulationRepository _regulationRepository;
  List<EditedParagraphInfo> _editedParagraphsInfo = [];

  Future<void> update(bool sortByColor) async {
    emit(NotesInitial());
    _editedParagraphsInfo = await getEditedParagraphs(sortByColor);
    List<Color> _colors = [];

    emit(NotesLoaded(
      colors: _colors,
      editedParagraphs: _editedParagraphsInfo,
    ));
  }

  Future<void> delete(EditedParagraphInfo paragraph) async {
    String _pContent = paragraph.content;

    Map<int, String> _tagsMap = getTags(_pContent);
    _tagsMap = clearTags(_tagsMap);
    String _content = getStringForSave(_tagsMap, parseHtmlString(_pContent));

    if (paragraph.edited == 1) {
      await _regulationRepository.saveParagraph(EditedParagraph(
          paragraphId: paragraph.paragraphID,
          chapterId: paragraph.chapterID,
          edited: 1,
          text: _content,
          lastTouched: DateTime.now().millisecondsSinceEpoch));
    } else {
      await _regulationRepository.deleteParagraph(paragraph.paragraphID);
    }

    update(false);
  }

  Future<List<EditedParagraphInfo>> getEditedParagraphs(
      bool sortByColor) async {
    List<EditedParagraphInfo> returnedValue = [];
    // Get all edited paragraphs from repository
    List<EditedParagraph> editedParagraphs =
        await _regulationRepository.getAllEditedParagraphs();

    for (final EditedParagraph editedPargraph in editedParagraphs) {
      List<EditedParagraphLink> _editedParagraphLinksList =
          getEditedParagraphLinks(editedPargraph.text);

      String _regulationAbbreviation =
          _regulationRepository.getRegulationAbbreviation();

      String chapterName =
          _regulationRepository.getChapterNameByID(editedPargraph.chapterId);

      _editedParagraphLinksList.forEach((editedParagraphLink) {
        EditedParagraphInfo _editedParagraphInfo = EditedParagraphInfo(
            chapterName: chapterName,
            chapterID: editedPargraph.chapterId,
            paragraphID: editedPargraph.paragraphId,
            link: editedParagraphLink,
            edited: editedPargraph.edited,
            regulationAbbriviation: _regulationAbbreviation,
            lastTouched: editedPargraph.lastTouched,
            content: editedPargraph.text);
        returnedValue.add(_editedParagraphInfo);
      });
    }
    if (sortByColor == false) {
      returnedValue.sort((a, b) => a.lastTouched.compareTo(b.lastTouched));
      return returnedValue;
    }

    returnedValue
        .sort((a, b) => a.link.color.value.compareTo(b.link.color.value));
    return returnedValue;
  }
}
