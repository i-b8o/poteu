import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poteu/repository/regulation_repository.dart';
import 'package:poteu/utils/text.dart';

part 'speak_state.dart';

class SpeakCubit extends Cubit<bool> {
  SpeakCubit({required RegulationRepository regulationRepository})
      : _regulationRepository = regulationRepository,
        super(false);

  Future<void> speak(String text) async {
    emit(true);
    text = parseHtmlString(text);
    text = text.replaceAll('-', ' ');
    List<String> _sentences = text.split(".");
    List<String> parts = [];
    for (var i = 0; i < _sentences.length; i++) {
      if (_sentences[i].split(" ").length > 40) {
        List<String> _parts = _sentences[i].split(",");
        parts = parts + _parts;
      } else {
        parts.add(_sentences[i]);
      }
    }

    for (var i = 0; i < parts.length; i++) {
      await _regulationRepository.speak(parts[i]);
    }
    emit(false);
  }

  final RegulationRepository _regulationRepository;

  Future<void> speakChapter(List<String> _editableParagraphs) async {
    emit(true);

    for (final String paragraph in _editableParagraphs) {
      await speak(paragraph);
    }
    emit(false);
  }

  Future<void> stop() async {
    emit(false);
    await _regulationRepository.ttsStop();
  }
}
