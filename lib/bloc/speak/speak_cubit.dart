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
    await _regulationRepository.speak(text).then((value) => emit(false));
  }

  final RegulationRepository _regulationRepository;

  Future<void> speakChapter(List<String> _editableParagraphs) async {
    emit(true);

    for (final String paragraph in _editableParagraphs) {
      String cleanParagraph = paragraph.replaceAll('-', ' ');
      await speak(cleanParagraph);
    }
    emit(false);
  }

  Future<void> stop() async {
    emit(false);
    await _regulationRepository.ttsStop();
  }
}
