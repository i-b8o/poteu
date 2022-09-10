import 'package:regulation_api/regulation_api.dart';

import 'package:sp_api/sp_api.dart';
import 'package:sqlite_api/sqlite_api.dart';
import 'package:tts_api/tts_api.dart';

import 'package:poteu/presentation/screens/search/model/editable_content_paragraph.dart';
import 'package:poteu/utils/errors.dart';
import 'package:poteu/utils/text.dart';

class RegulationRepository {
  const RegulationRepository({
    required RegulationApi regulationApi,
    required SPApi spApi,
    required SqliteApi sqliteApi,
    required TTSApi ttsApi,
  })  : _regulationApi = regulationApi,
        _spApi = spApi,
        _sqliteApi = sqliteApi,
        _ttsApi = ttsApi;

  final RegulationApi _regulationApi;
  final SPApi _spApi;
  final SqliteApi _sqliteApi;
  final TTSApi _ttsApi;

// Regulation API
  String getRegulationAbbreviation() {
    try {
      return _regulationApi.getRegulationAbbreviation();
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
      return "";
    }
  }

  List<ChapterInfo> getTableOfContents() {
    try {
      return _regulationApi.getTableOfContents();
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
      return [];
    }
  }

  Future<List<EditableParagraph>> getParagraphsByChapterOrderNum(
      int chapterOrderNum) async {
    try {
      List<EditableParagraph> returnedParagraphs = [];
      List<Paragraph> _paragraphs =
          _regulationApi.getParagraphsByChapterOrderNum(chapterOrderNum);
      List<EditedParagraph> _edited = await _sqliteApi
          .getEditedParagraphsForChapter(_paragraphs.first.chapterID);

      for (Paragraph p in _paragraphs) {
        List<EditedParagraph> ep =
            _edited.where((element) => element.paragraphId == p.id).toList();

        EditableParagraph newParagraph = EditableParagraph(
            chapterID: p.chapterID,
            content: p.content,
            id: p.id,
            editableParagraphClass: p.paragraphClass,
            isHTML: p.isHTML,
            isNFT: p.isNFT,
            isTable: p.isTable,
            edited: 0,
            num: p.num);
        if (ep.isNotEmpty) {
          newParagraph.content = ep.first.text;
          newParagraph.edited = ep.first.edited;
        }
        returnedParagraphs.add(newParagraph);
      }
      return returnedParagraphs;
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
      return [];
    }
  }

  List<int> getChapterAndParagraphOrderNums(int chapterID, paragraphID) {
    try {
      return _regulationApi.getChapterAndParagraphOrderNums(
          chapterID, paragraphID);
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
      return [0, 0];
    }
  }

  String getChapterNameByOrderNum(int chapterOrderNum) {
    try {
      return _regulationApi.getChapterNameByOrderNum(chapterOrderNum);
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
      return "";
    }
  }

  String getChapterNameByID(int chapterID) {
    try {
      return _regulationApi.getChapterNameByID(chapterID);
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
      return "";
    }
  }

  String getRegulationName() {
    try {
      return _regulationApi.getRegulationName();
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
      return "";
    }
  }

  GoTo? getGoTo(int id) {
    try {
      return _regulationApi.getGoTo(id);
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
      return GoTo(
          regId: Regulation.id, chapterOrderNum: 1, paragraphOrderNum: 1);
    }
  }

  List<EditableContentParagraph> search(String query) {
    try {
      List<EditableContentParagraph> _returnedList = [];
      List<Paragraph> _paragraphs = _regulationApi.search(query);
      query = query.toLowerCase().trim();

      for (Paragraph p in _paragraphs) {
        String modifiedContent = removeAllTagsExceptLinks(p.content);
        modifiedContent = modifiedContent.replaceAll(
            query, "<span style='background-color:#FFFF00;'>${query}</span>");
        _returnedList.add(
            EditableContentParagraph(paragraph: p, content: modifiedContent));
      }
      return _returnedList;
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
      return [];
    }
  }

// Theme
  setTheme(bool value) async {
    try {
      return await _spApi.setTheme(value);
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
    }
  }

  getTheme() {
    try {
      return _spApi.getTheme();
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
    }
  }

// Colors
  setColorPickerColors(List<int> colors) async {
    try {
      return await _spApi.setColorPickerColors(colors);
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
    }
  }

  bool colorPickerKeyExist() {
    try {
      return _spApi.colorPickerConfigured();
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
      return false;
    }
  }

  List<int> getColorPickerColors() {
    try {
      List<String>? colorsStr = _spApi.getColorPickerColors();
      if (colorsStr == null) {
        return [
          0xFF525965,
          0xFFffa200,
          0xFFff3063,
          0xFF00d2b0,
          0xFF8963ff,
          0xFF007fff,
        ];
      }
      List<int> _colorsIntList = [];
      for (final _color in colorsStr) {
        int? _colorInt = int.tryParse(_color);
        if (_colorInt != null) {
          _colorsIntList.add(_colorInt);
        }
      }
      return _colorsIntList;
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
      return [];
    }
  }

  setActiveColorIndex(int index) async {
    try {
      return await _spApi.setActiveColorIndex(index);
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
    }
  }

  int getActiveColorIndex() {
    try {
      return _spApi.getActiveColorIndex() ?? 4;
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
      return 4;
    }
  }

// Sqlite
  Future<void> saveParagraph(EditedParagraph paragraph) async {
    try {
      return await _sqliteApi.saveParagraph(paragraph);
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
    }
  }

  Future<void> deleteParagraph(int id) async {
    try {
      return await _sqliteApi.deleteParagraph(id);
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
    }
  }

  Future<List<EditedParagraph>> getAllEditedParagraphs() async {
    try {
      return await _sqliteApi.getAllEditedParagraphs();
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
      return [];
    }
  }

// Shared prefs
  Future setPitch(double pitch) async {
    try {
      await _spApi.setPitch(pitch);
      await _ttsApi.setPitch(pitch);
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
    }
  }

  Future setSpeechRate(double speechrate) async {
    try {
      await _spApi.setSpeechRate(speechrate);
      await _ttsApi.setSpeechRate(speechrate);
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
    }
  }

  Future<TTSSettings> getSettings() async {
    try {
      double _pitch = _spApi.getPitch() ?? 0.5;
      double _speechRate = _spApi.getSpeechRate() ?? 0.5;
      double _volume = _spApi.getVolume() ?? 0.5;
      String _voice = _spApi.getVoice() ?? "";
      TTSSettings _return = TTSSettings(
          pitch: _pitch,
          speechRate: _speechRate,
          volume: _volume,
          voice: _voice);

      TTSSettings _ttsSettings = _ttsApi.getSettings();
      if (_pitch != _ttsSettings.pitch) {
        await _ttsApi.setPitch(_pitch);
      }
      if (_speechRate != _ttsSettings.speechRate) {
        await _ttsApi.setSpeechRate(_pitch);
      }

      if (_volume != _ttsSettings.volume) {
        await _ttsApi.setVolume(_volume);
      }
      if (_voice != _ttsSettings.voice) {
        await _ttsApi.setVoice(_voice);
      }
      return _return;
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
      return TTSSettings(
          pitch: 0.5, speechRate: 0.5, volume: 0.5, voice: "Пусто");
    }
  }

// TTS
  Future setVolume(double volume) async {
    try {
      await _spApi.setVolume(volume);
      await _ttsApi.setVolume(volume);
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
    }
  }

  Future setVoice(String voice) async {
    try {
      await _spApi.setVoice(voice);
      await _ttsApi.setVoice(voice);
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
    }
  }

  Future<void> stop() async {
    try {
      await _ttsApi.stop();
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
    }
  }

  Future<void> speak(String text) async {
    try {
      await _ttsApi.speak(text);
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
    }
  }

  Future<bool> checkRuLanguage() async {
    try {
      return await _ttsApi.checkRuLanguage();
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
      return false;
    }
  }

  Future<List<String>?> getVoices() async {
    try {
      List<String>? _voices = await _ttsApi.getVoices();
      // Drop duplicates
      return _voices != null ? _voices.toSet().toList() : _voices;
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
      return null;
    }
  }

// Fonts
  Future setFontSize(double fontSize) async {
    try {
      await _spApi.setFontSize(fontSize);
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
    }
  }

  double getFontSize() {
    try {
      return _spApi.getFontSize() ?? 0;
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
      return 0.0;
    }
  }

  Future setFontWeight(double fontWeight) async {
    try {
      await _spApi.setFontWeight(fontWeight);
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
    }
  }

  double getFontWeight() {
    try {
      return _spApi.getFontWeight() ?? 0.375;
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
      return 0.1;
    }
  }

  Future resetFont() async {
    try {
      await _spApi.resetFont();
    } catch (exception, stackTrace) {
      sendError(exception, stackTrace);
    }
  }
}
