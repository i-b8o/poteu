import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:regulation_api/regulation_api.dart';

import 'package:poteu/repository/regulation_repository.dart';

part 'paragraph_card_state.dart';

class ParagraphCardCubit extends Cubit<ParagraphCardState> {
  ParagraphCardCubit({required RegulationRepository regulationRepository})
      : _regulationRepository = regulationRepository,
        super(ParagraphCardInitial());

  final RegulationRepository _regulationRepository;

  GoTo? goTo(int? chapterID, paragraphID) =>
      _regulationRepository.getGoTo(chapterID, paragraphID);
}
