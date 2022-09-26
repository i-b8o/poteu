import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poteu/repository/regulation_repository.dart';
part 'speak_state.dart';

class SpeakCubit extends Cubit<bool> {
  SpeakCubit({required RegulationRepository regulationRepository})
      : _regulationRepository = regulationRepository,
        super(false);

  Future<void> speak(List<String> text) async {
    emit(true);
    for (var i = 0; i < text.length; i++) {
      await _regulationRepository.speak(text[i]);
    }
    emit(false);
  }

  final RegulationRepository _regulationRepository;

  // Future<void> speakChapter(List<String> _editableParagraphs) async {
  //   emit(true);

  //   for (final String paragraph in _editableParagraphs) {
  //     await speak(paragraph);
  //   }
  //   emit(false);
  // }

  Future<void> stop() async {
    emit(false);
    await _regulationRepository.ttsStop();
  }
}
