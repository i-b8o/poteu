import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:regulation_api/regulation_api.dart';
import 'package:sqlite_api/sqlite_api.dart';

import '../../../../../repository/regulation_repository.dart';
import '../../../../../utils/text.dart';
import '../../model/span.dart';

part 'save_paragraph_state.dart';

class SaveParagraphCubit extends Cubit<SaveParagraphState> {
  SaveParagraphCubit(
      {required RegulationRepository regulationRepository,
      required EditableParagraph paragraph})
      : _regulationRepository = regulationRepository,
        _paragraph = paragraph,
        super(SaveParagraphInitial());

  final RegulationRepository _regulationRepository;
  late EditableParagraph _paragraph;

  int _start = 0;
  int _end = 0;
  int _orderNum = 0;
  int get orderNum => _orderNum;

  setOffset(int start, end, pOrderNum, EditableParagraph paragraph) {
    _paragraph = paragraph;
    _start = start;
    _end = end;
    _orderNum = orderNum;
  }

  Future<void> cleanEditedParagraphs() async {
    if (_end == _start) {
      emit(SaveParagraphEmptySelected(Tag.c));
      return;
    }
    String _pContent = _paragraph.content;

    Map<int, String> _tagsMap = getTags(_pContent);
    _tagsMap = clearTags(_tagsMap);
    String _content = getStringForSave(_tagsMap, parseHtmlString(_pContent));

    await _regulationRepository.saveParagraph(EditedParagraph(
        paragraphId: _paragraph.id,
        chapterId: _paragraph.chapterID,
        text: _content,
        lastTouched: DateTime.now().millisecondsSinceEpoch,
        edited: 1));
  }

  Future<void> saveEditedParagraph(
      EditableParagraph paragraph, String content) async {
    // Get links
    Map<String, String> _links = getLinks(paragraph.content);

    if (!_links.isEmpty) {
      for (var k in _links.keys) {
        String value = _links[k] ?? "";
        content = content.replaceAll(k, value);
      }
    }

    await _regulationRepository.saveParagraph(EditedParagraph(
      paragraphId: paragraph.id,
      chapterId: paragraph.chapterID,
      text: content,
      lastTouched: DateTime.now().millisecondsSinceEpoch,
      edited: 1,
    ));
  }

  Future<void> saveFormatedParagraph(Tag tag, int spanColor) async {
    if (_end == _start) {
      emit(SaveParagraphEmptySelected(tag));
      return;
    }
    String _openTag = "";
    String _closeTag = "";

    String color =
        '${spanColor.toRadixString(16).padLeft(6, '0').toUpperCase().substring(2)}';

    String _pContent = _paragraph.content;
    Map<int, String> _tagsMap = getTags(_pContent);
    String _content = "";

    Tag _tag = tag;
    if (_tag != Tag.c) {
      switch (_tag) {
        case Tag.m:
          _openTag = '<span style="background-color:#$color;">';
          _closeTag = '</span>';
          break;

        case Tag.u:
          _openTag = '<u style="text-decoration-color:#$color;">';
          _closeTag = '</u>';
          break;
        default:
          break;
      }
      _tagsMap = addTag(_tagsMap, _openTag, _start);
      _tagsMap = addTag(_tagsMap, _closeTag, _end);
    } else {
      _tagsMap = clearTags(_tagsMap);
    }

    _content = getStringForSave(_tagsMap, parseHtmlString(_pContent));

    await _regulationRepository.saveParagraph(EditedParagraph(
        paragraphId: _paragraph.id,
        chapterId: _paragraph.chapterID,
        text: _content,
        lastTouched: DateTime.now().millisecondsSinceEpoch,
        edited: _paragraph.edited));
  }
}
